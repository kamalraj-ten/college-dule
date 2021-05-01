import 'package:firebase_database/firebase_database.dart';
import 'package:collegedule/CustomUser.dart';

import 'event.dart';

class DatabaseManager {
  final dbRef = FirebaseDatabase.instance.reference();
  static final manager = new DatabaseManager();

  Future<List<CustomUser>> getUsers() async {
    List<CustomUser> customUsers = [];
    DataSnapshot dataSnapshot = await dbRef.child("public").once();
    final values = Map<String, dynamic>.from(dataSnapshot.value);
    values.forEach((key, value) {
      if (value != null) {
        customUsers.add(new CustomUser(
            name: value['name'],
            password: value['password'],
            college: value['college'],
            department: value['department'],
            email: value['email']));
      }
    });
    print(customUsers);
    return customUsers;
  }

  Future<CustomUser> getUser(email) async {
    List<CustomUser> users = await this.getUsers();
    for (CustomUser c in users) {
      if (c.email == email) return c;
    }
    return null;
  }

  Future<bool> storeUser(CustomUser customUser) async {
    final DatabaseReference reference = dbRef.child("public");
    try {
      await reference.push().set({
        "password": customUser.password,
        "name": customUser.name,
        "college": customUser.college,
        "department": customUser.department,
        "email": customUser.email
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addEvent(ClubEvent event) async {
    try {
      final DatabaseReference reference = dbRef.child("event");
      await reference.push().set(event.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ClubEvent>> getEvents(String email) async {
    List<ClubEvent> events = [];
    DataSnapshot snapshot = await dbRef.child("event").once();
    final map = Map<String, dynamic>.of(snapshot.value);
    map.forEach((key, value) {
      if (value != null && value['email'] == email) {
        events.add(new ClubEvent.fromMap(value));
      }
    });
    return events;
  }
}
