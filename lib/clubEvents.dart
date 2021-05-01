import 'package:collegedule/Plan.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ClubEvents extends StatelessWidget {
  final clubEventsRef = FirebaseFirestore.instance.collection("club_events");
  String college, department;

  ClubEvents() {
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: clubEventsRef
          //.where("college", arrayContainsAny: ["any", this.college])
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("an error occured");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            final data = document.data()['date'].toDate();
            final dateFormat = DateFormat.yMd().add_jm();
            final date = dateFormat.format(data);

            if (data.toString().compareTo(DateTime.now().toString()) < 0)
              print("dead date");
            else
              print("live date");

            return Schedule(
              date: date,
              text: document.data()['event'].toString(),
            );
          }).toList(),
        );
      },
    );
  }

  void getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    this.college = prefs.getString("college");
    this.department = prefs.getString("department");
  }
}
