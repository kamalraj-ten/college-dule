import 'package:flutter/material.dart';

class FriendAddPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

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
                decoration: InputDecoration(
                  labelText: "Friend's email id",
                ),
              ),
              Center(
                child: TextButton(
                  child: Text("Add friend"),
                  onPressed: () => onSubmit(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    // TODO : complete validation and adding friend
    print('clicked add friend');
  }
}
