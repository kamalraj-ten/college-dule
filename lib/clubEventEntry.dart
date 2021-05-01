import 'package:collegedule/event.dart';
import 'package:collegedule/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// a page for club event entry
class ClubEventEntry extends StatefulWidget {
  @override
  _ClubEventEntryState createState() => _ClubEventEntryState();
}

class _ClubEventEntryState extends State<ClubEventEntry> {
  final formKey = GlobalKey<FormState>();

  ClubEvent _clubEvent =
      new ClubEvent(college: "any", department: "any", club: "STUDENT COUNCIL");

  List<String> colleges = [
    "any",
    "COLLEGE OF ENGINEERING, GUINDY",
    "ALAGAPPA COLLEGE OF ENGINEERING",
    "PSG COLLEGE OF TECHNOLOGY",
    "KONGU COLLEGE OF ENGINEERING",
    "KUMARAGURU COLLEGE OF ENGINEERING"
  ];

  List<String> departments = [
    "any",
    "MECHANICAL",
    "ECE",
    "EEE",
    "CSE",
    "CIVIL",
    "FASHION"
  ];

  final List<String> clubs = [
    "STUDENT COUNCIL",
    "YOUTH OUTREACH CLUB",
    "ANIMAL WELFARE",
    "PHOTOGRAPHY",
    "RADIO CLUB",
    "TAMIL MANDRAM",
    "HINDI CLUB"
  ];

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (s) => _checkEvent(s),
                  onSaved: (s) => _clubEvent.event = s,
                  decoration: InputDecoration(
                    labelText: "Event",
                  ),
                ),
                DropdownButton(
                  value: _clubEvent.college,
                  icon: Icon(Icons.arrow_drop_down),
                  items: colleges.map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem(
                      child: Text(val),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (String s) {
                    setState(() {
                      _clubEvent.college = s;
                    });
                  },
                ),
                DropdownButton(
                  value: _clubEvent.department,
                  icon: Icon(Icons.arrow_drop_down),
                  items:
                      departments.map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem(
                      child: Text(val),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (String s) {
                    setState(() {
                      _clubEvent.department = s;
                    });
                  },
                ),
                DropdownButton(
                  value: _clubEvent.club,
                  icon: Icon(Icons.arrow_drop_down),
                  items: clubs.map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem(
                      child: Text(val),
                      value: val,
                    );
                  }).toList(),
                  onChanged: (String s) {
                    setState(() {
                      _clubEvent.club = s;
                    });
                  },
                ),
                Center(
                  child: TextButton(
                    child: Text(
                        "Select date : ${selectedDate.day}/${selectedDate.month}/${selectedDate.year} (click to change)"),
                    onPressed: () => _selectDate(),
                  ),
                ),
                Center(
                  child: TextButton(
                    child: Text("create event"),
                    onPressed: () => onSubmit(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _checkEvent(String s) {
    return s.isEmpty ? "Enter an event" : null;
  }

  Future<void> onSubmit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      // other jobs
      // create event
      final prefs = await SharedPreferences.getInstance();
      _clubEvent.date = selectedDate;
      _clubEvent.email = prefs.getString("email");
      _clubEvent.uid = prefs.getString("uid");
      await addClubEvent(_clubEvent);
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 40)),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: "Select date of the event",
        errorInvalidText: "Only 40 days from current day is allowed");
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }
}
