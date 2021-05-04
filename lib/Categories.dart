import 'package:collegedule/Plan.dart';
import 'package:collegedule/clubEvents.dart';
import 'package:collegedule/flutterfire.dart';
import 'package:collegedule/friendAddPage.dart';
import 'package:collegedule/friendEventAddPage.dart';
import 'package:collegedule/friendsEvents.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String title = "all events";
  int selectedIndex = 1;
  String uid;
  List<String> friendsUid;
  Map<String, String> usersEmailId;

  final pages = [
    new ClubEvents(),
    new Schedules(),
    new Schedules(),
  ];

  _CategoriesState() {
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("logged_in", false);
                bool signedOut = await signOut();
                if (signedOut)
                  Navigator.pushReplacementNamed(context, "/log_in");
              }),
          selectedIndex == 2
              ? IconButton(
                  icon: Icon(
                    Icons.person_add_rounded,
                    semanticLabel: "add friend",
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendAddPage(
                                  usersEmailId: this.usersEmailId,
                                  uid: this.uid,
                                  friendsUid: this.friendsUid,
                                )));
                  })
              : Container(),
        ],
      ),
      body: this.pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purpleAccent,
        currentIndex: selectedIndex,
        onTap: (selectedIndex) {
          setState(() {
            this.selectedIndex = selectedIndex;
            switch (selectedIndex) {
              case 0:
                this.title = "Club Events";
                break;
              case 1:
                this.title = "All Events - Home";
                break;
              case 2:
                this.title = "Friends";
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Club Event"),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Friends")
        ],
      ),
      // floating action bar is only needed for club events, and friends
      floatingActionButton: selectedIndex != 1
          ? FloatingActionButton(
              onPressed: () async {
                if (selectedIndex == 0)
                  Navigator.pushNamed(context, "/club_event_entry");
                else {
                  // go to friend event add page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FriendEventAddPage(uid: uid)
                    ),
                  );
                }
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  void getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    this.uid = prefs.getString("uid");
    this.friendsUid = await getFriendsUid(uid);
    this.usersEmailId = await getUsersEmail();
  }
}
