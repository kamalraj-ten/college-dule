import 'package:firebase_database/firebase_database.dart';

class CustomUser {
  String name, password, college, department, email;

  CustomUser({this.name, this.password, this.college, this.department, this.email = "abc@email.com"});

  @override
  String toString() {
    return 'User{name: $name, password: $password, college: $college, department: $department, email: $email}';
  }

  Map toMap() {
    return {
      "name": name,
      "password": password,
      "college": college,
      "department": department,
      "email": email
    };
  }

  void fromMap(Map<String, dynamic> value) {
    name = value['name'];
    password = value['password'];
    college = value['college'];
    department = value['department'];
    email = value['email'];
  }

  CustomUser.fromSnapshot(DataSnapshot snapshot) {
    final value = snapshot.value;
    name = value['name'];
    password = value['password'];
    college = value['college'];
    department = value['department'];
    email = value['email'];
  }
}