import 'package:collegedule/DatabaseManager.dart';
import 'package:collegedule/flutterfire.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomUser.dart';

class LogInPage extends StatelessWidget {
  String email = "", password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("college-dule - log in"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                onChanged: (s) {
                  email = s;
                },
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                onChanged: (s) {
                  password = s;
                },
                obscureText: true,
                decoration: InputDecoration(labelText: "password"),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        logIn(context);
                      },
                      child: Text("Log In"),
                      style: TextButton.styleFrom(
                          primary: Colors.white, backgroundColor: Colors.blue),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/sign_up");
                        },
                        child: Text("new user"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void logIn(BuildContext context) async {
    // deploy using shared prefs for now
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      bool canLogIn = await signIn(email, password);
      if (canLogIn) {
        prefs.setBool("logged_in", true);
        Navigator.pushReplacementNamed(context, "/categories");
      }
    } catch (e) {
      print(e);
    }
  }
}
