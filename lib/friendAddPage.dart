import 'package:flutter/material.dart';

import 'flutterfire.dart';

class FriendAddPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  Map<String, String> usersEmailId;
  String emailId, uid, friendUid;
  List<String> friendsUid;

  FriendAddPage({this.usersEmailId, this.uid, this.friendsUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a friend"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (s) => _validateEmailId(s),
                onSaved: (s) => this.emailId = s,
                decoration: InputDecoration(
                  labelText: "Friend's email id",
                ),
              ),
              Center(
                child: TextButton(
                  child: Text("Add friend"),
                  onPressed: () => onSubmit(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _validateEmailId(String s) {
    if (s.isEmpty)
      return "Enter the email id";
    else {
      for (String key in this.usersEmailId.keys) {
        if (this.usersEmailId[key].compareTo(s) == 0 &&
            key.compareTo(uid) != 0) {
          if (this.friendsUid.contains(key)) return "Already in friends list";
          this.friendUid = key; // key is the uid
          return null;
        }
      }
    }
    return "No match found";
  }

  void onSubmit(context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      await addFriend(uid, friendUid);
      Navigator.pop(context);
    }
  }
}
