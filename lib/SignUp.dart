import 'package:flutter/material.dart';
import 'CustomUser.dart';
import 'flutterfire.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  String name = "", username = "", password = "", confirmation = "", email = "";
  List<String> colleges = [
    "COLLEGE OF ENGINEERING, GUINDY",
    "ALAGAPPA COLLEGE OF ENGINEERING",
    "PSG COLLEGE OF TECHNOLOGY",
    "KONGU COLLEGE OF ENGINEERING",
    "KUMARAGURU COLLEGE OF ENGINEERING"
  ];
  List<String> departments = [
    "MECHANICAL",
    "ECE",
    "EEE",
    "CSE",
    "CIVIL",
    "FASHION"
  ];
  String college = "COLLEGE OF ENGINEERING, GUINDY", department = "MECHANICAL";

  final _formStateKey = GlobalKey<FormState>();
  CustomUser _customUser = CustomUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: SafeArea(
            child: Center(
              child: Form(
                key: _formStateKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (s) {
                        email = s;
                      },
                      validator: (s) => validateEmail(s),
                      onSaved: (s) => _customUser.email = s,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                    TextFormField(
                      onChanged: (s) {
                        this.name = s;
                      },
                      validator: (s) => validateName(s),
                      onSaved:  (s) => _customUser.name = s,
                      decoration: InputDecoration(
                        labelText: "name",
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (s) {
                        password = s;
                      },
                      onSaved: (s) => _customUser.password = s,
                      validator: (s) => validatePassword(s),
                      decoration: InputDecoration(
                        labelText: "password",
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (s) {
                        confirmation = s;
                      },
                      validator: (s) => validateConfirmation(s),
                      decoration: InputDecoration(
                        labelText: "confirmation password"
                      ),
                    ),
                    DropdownButton(
                      value: college,
                      icon: Icon(Icons.arrow_drop_down),
                      items: colleges.map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem(child: Text(val), value: val,);
                      }).toList(),
                      onChanged: (String s) {
                        setState(() {
                          this.college = s;
                        });
                      },
                    ),
                    DropdownButton(
                      value: department,
                      icon: Icon(Icons.arrow_drop_down),
                      items: departments.map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem(child: Text(val), value: val,);
                      }).toList(),
                      onChanged: (String s) {
                        setState(() {
                          this.department = s;
                        });
                      },
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          primary: Colors.white
                        ),
                        child: Text("sign up!",
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                        onPressed: () => onSubmit(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  // validation methods
  String validateName(String s) {
    return s.isEmpty ? "Enter a name" : null;
  }

  String validateConfirmation(String s) {
    if(s.isEmpty || password.compareTo(s) != 0) return "Didn't match or empty";
    return null;
  }

  String validatePassword(String s) {
    if(s.length < 6) return "password should be greater than 6 character";
    return null;
  }

  void onSubmit() async {
    if(_formStateKey.currentState.validate()) {
      _formStateKey.currentState.save();

      // other jobs
      _customUser.department = this.department;
      _customUser.college = this.college;
      print(_customUser);
      bool isUserCreated = await register(this.email, this.password, _customUser);

      if(isUserCreated) {
        Navigator.pop(context);
      }
    }
  }

  String validateEmail(String s) {
    if(s.isEmpty) return "enter email";
    return null;
  }
}
