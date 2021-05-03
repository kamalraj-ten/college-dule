import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedule/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendsEvents extends StatelessWidget {
  final friendsEventRef =
      FirebaseFirestore.instance.collection("friends_events");

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
              .where((element) => true)
              .map((DocumentSnapshot documentSnapshot) {})
              .toList(),
        );
      },
    );
  }
}
