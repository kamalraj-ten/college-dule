import 'package:collegedule/Plan.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClubEvents extends StatelessWidget {
  final clubEventsRef = FirebaseFirestore.instance.collection("club_events");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: clubEventsRef.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("an error occured");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) => Schedule(
            date: document.data()['date'].toDate().toString(),
            text: document.data()['event'].toString(),
          )).toList(),
        );
      },
    );
  }
}
