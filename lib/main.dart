import 'package:collegedule/Categories.dart';
import 'package:collegedule/DatabaseManager.dart';
import 'package:collegedule/LogIn.dart';
import 'package:collegedule/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Plan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/" : (context) => Home(),
        "/log_in" : (context) => LogInPage(),
        "/sign_up": (context) => SignUpPage(),
        "/schedules": (context) => Schedules(),
        "/categories": (context) => Categories()
      },
    );
  }
}

class Home extends StatelessWidget {

  bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoggedIn(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
            break;
          default:
            if(snapshot.hasError) {
              print("error");
              return Text("error");
            } else if(isLoggedIn) {
              return Schedules();
            } else {
              return LogInPage();
            }
        }
      },
    );
  }

  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("logged_in")) {
      if(prefs.getBool("logged_in")) {
        isLoggedIn = true;
        return true;
      }
      isLoggedIn = false;
      return false;
    } else {
      prefs.setBool("logged_in", false);
      isLoggedIn = false;
      return false;
    }
  }
}

