import 'package:collegedule/Plan.dart';
import 'package:collegedule/event.dart';
import 'package:collegedule/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ClubEvents extends StatelessWidget {
  final clubEventsRef = FirebaseFirestore.instance.collection("club_events");
  String college, department, id;

  ClubEvents() {
    getPrefs();
  }

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
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            final data = document.data()['date'].toDate();
            final dateFormat = DateFormat.yMd().add_jm();
            final date = dateFormat.format(data);

            // return only if college and department is valid
            ClubEvent clubEvent = ClubEvent.fromMap(document.data());
            if (!checkClubEvent(clubEvent)) {
              print(clubEvent);
              return Container();
            }

            return Schedule(
              date: date,
              text: document.data()['event'].toString(),
              id: document.data()['uid'].toString(),
              uid: id,
              eventId: document.id,
              onClick: removeEvent,
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
    this.id = prefs.getString("uid");
    await removeOutdatedClubEvents();
  }

  bool checkClubEvent(ClubEvent event) {
    if (event.college.compareTo("any") == 0 ||
        event.college.compareTo(this.college) == 0) {
      if (event.department.compareTo("any") == 0 ||
          event.department.compareTo(this.department) == 0) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
