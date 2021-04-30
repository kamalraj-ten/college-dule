import 'package:collegedule/Plan.dart';
import 'package:collegedule/clubEvents.dart';
import 'package:collegedule/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DatabaseManager.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  String title = "all events";
  int selectedIndex = 1;

  final pages = [
    new ClubEvents(),
    new Schedules(),
    new Schedules(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.logout),
              onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("logged_in", false);
            bool signedOut = await signOut();
            if(signedOut) Navigator.pushReplacementNamed(context, "/log_in");
          })
        ],
      ),
      body: this.pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purpleAccent,
        currentIndex: selectedIndex,
        onTap: (selectedIndex) {
          setState(() {
            this.selectedIndex = selectedIndex;
            switch(selectedIndex) {
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
          BottomNavigationBarItem(icon: Icon(Icons.event),
          label: "Club Event" ),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled),
          label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person),
          label: "Friends")
        ],
      ),
      // floating action bar is only needed for club events, and friends
      floatingActionButton: selectedIndex != 1 ? FloatingActionButton(
        onPressed: () async {
          DatabaseManager.manager.getUsers().then((value) => print(value));
        },
        child: Icon(Icons.add),
      ) : null,
    );
  }
}
