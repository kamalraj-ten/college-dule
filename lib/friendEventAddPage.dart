import 'package:collegedule/event.dart';
import 'package:flutter/material.dart';

import 'flutterfire.dart';

class FriendEventAddPage extends StatefulWidget {
  final uid;
  FriendEventAddPage({this.uid});
  @override
  _FriendEventAddPageState createState() => _FriendEventAddPageState(uid: uid);
}

class _FriendEventAddPageState extends State<FriendEventAddPage> {
  final uid;
  final formKey = GlobalKey<FormState>();
  FriendEvent _friendEvent = FriendEvent(event: "", date: DateTime.now());

  _FriendEventAddPageState({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (s) => _validateEvent(s),
                  onSaved: (s) => this._friendEvent.event = s,
                  decoration: InputDecoration(
                    labelText: "event subject",
                  ),
                ),
                Container(
                  height: 10,
                ),
                OutlinedButton(
                  child: Text(
                    "Select date : ${_friendEvent.date.day}/${_friendEvent.date.month}/${_friendEvent.date.year} (click to change)",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () => _selectDate(),
                ),
                Container(
                  height: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                  ),
                  child: Text("Create event"),
                  onPressed: () => onSubmit(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateEvent(String s) {
    return s.isEmpty ? "Enter an event subject" : null;
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
        context: context,
        initialDate: _friendEvent.date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 40)),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: "Select date of the event",
        errorInvalidText: "Only 40 days from current day is allowed");
    if (date != null) {
      setState(() {
        _friendEvent.date = date;
      });
    }
  }

  Future<void> onSubmit() async {
    if (this.formKey.currentState.validate()) {
      this.formKey.currentState.save();
      _friendEvent.uid = uid;
      await addFriendEvent(_friendEvent);
      Navigator.pop(context);
    }
  }
}
