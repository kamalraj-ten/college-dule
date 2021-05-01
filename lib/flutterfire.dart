import 'package:collegedule/CustomUser.dart';
import 'package:collegedule/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> register(
    String email, String password, CustomUser customUser) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await createUser(userCredential.user, customUser);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      print(e.code);
    } else if (e.code == "email-already-in-use") {
      print(e.code);
    }
  } catch (e) {
    print(e);
  }
  return false;
}

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await addUserToSharedPrefs(email);
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}

Future<bool> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return true;
  } on FirebaseAuthException catch (e) {
    print(e);
  }
  return false;
}

Future<void> createUser(User user, CustomUser customUser) async {
  await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
    "email": user.email,
    "uid": user.uid,
    "college": customUser.college,
    "department": customUser.department,
    "name": customUser.name
  });
}

Future<void> addUserToSharedPrefs(String email) async {
  final prefs = await SharedPreferences.getInstance();
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("users").get();

  snapshot.docs.forEach((document) {
    if (document["email"].toString().compareTo(email) == 0) {
      prefs.setString("email", email);
      prefs.setString("college", document["college"]);
      prefs.setString("department", document["department"]);
      prefs.setString("name", document["name"]);
      prefs.setString("uid", document["uid"]);
    }
  });
}

Future<void> addClubEvent(ClubEvent clubEvent) async {
  try {
    await FirebaseFirestore.instance
        .collection("club_events")
        .add(clubEvent.toMap());
  } catch (e) {
    print(e);
  }
}
