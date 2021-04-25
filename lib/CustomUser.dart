import 'package:firebase_database/firebase_database.dart';

class CustomUser {
  String username, name, password, college, department, email;

  CustomUser({this.username, this.name, this.password, this.college, this.department, this.email = "abc@email.com"});

  @override
  String toString() {
    return 'User{username: $username, name: $name, password: $password, college: $college, department: $department, email: $email}';
  }

  Map toMap() {
    return {
      "username": username,
      "name": name,
      "password": password,
      "college": college,
      "department": department,
      "email": email
    };
  }

  void fromMap(Map<String, dynamic> value) {
    username = value['username'];
    name = value['name'];
    password = value['password'];
    college = value['college'];
    department = value['department'];
    email = value['email'];
  }

  CustomUser.fromSnapshot(DataSnapshot snapshot) {
    final value = snapshot.value;
    username = value['username'];
    name = value['name'];
    password = value['password'];
    college = value['college'];
    department = value['department'];
    email = value['email'];
  }
}