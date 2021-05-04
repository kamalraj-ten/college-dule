import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedule/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Plan.dart';

class FriendsEvents extends StatelessWidget {
  final friendsEventRef =
      FirebaseFirestore.instance.collection("friend_event");
  String uid;
  List<String> friendsUid;

  FriendsEvents() {
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: friendsEventRef.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("an error occured");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text("no events to occur"),
          );
        }

        return ListView(
          children: snapshot.data.docs
          .where((element) => isFriend(element.data()['uid']))
          .map((DocumentSnapshot documentSnapshot) {
            final data = documentSnapshot.data();
            final dateFormat = DateFormat.yMd().add_jm();
            final date = dateFormat.format(data['date'].toDate());
            return Schedule(
              text: data['event'],
              date: date,
              uid: uid,
              id: data['uid'],
              eventId: documentSnapshot.id,
              onClick: removeFriendEvent,
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    this.uid = prefs.getString("uid");
    this.friendsUid = await getFriendsUid(uid);
    await removeOutdatedFriendEvents();
  }

  bool isFriend(String uid) {
    return this.friendsUid.contains(uid);
  }
}
