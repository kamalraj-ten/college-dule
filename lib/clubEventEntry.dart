import 'package:collegedule/event.dart';
import 'package:flutter/material.dart';

// a page for club event entry
class ClubEventEntry extends StatefulWidget {
  @override
  _ClubEventEntryState createState() => _ClubEventEntryState();
}

class _ClubEventEntryState extends State<ClubEventEntry> {
  final formKey = GlobalKey<FormState>();

  ClubEvent _clubEvent = new ClubEvent();

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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
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
                items: departments.map<DropdownMenuItem<String>>((String val) {
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
    );
  }

  String _checkEvent(String s) {
    return s.isEmpty ? "Enter an event" : null;
  }

  void onSubmit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      // other jobs
      // create event
      Navigator.pop(context);
    }
  }
}
