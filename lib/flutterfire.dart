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
    // create a friend list
    await FirebaseFirestore.instance
        .collection("friends")
        .doc(userCredential.user.uid)
        .set({
      "friends": [userCredential.user.uid],
    });
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

Future<void> removeOutdatedClubEvents() async {
  try {
    List<String> keys = [];
    await FirebaseFirestore.instance
        .collection("club_events")
        .get()
        .then((QuerySnapshot value) {
      value.docs.forEach((DocumentSnapshot element) {
        // remove if the date is less than today
        if (compareDate(element.data()['date'].toDate(), DateTime.now()) < 0)
          keys.add(element.id);
      });
    });
    final refs = FirebaseFirestore.instance.collection("club_events");
    keys.forEach((element) {
      refs.doc(element).delete();
    });
  } catch (e) {
    print(e);
  }
}

int compareDate(DateTime date1, DateTime date2) {
  if (date1.year < date2.year)
    return -1;
  else if (date1.month < date2.month)
    return -1;
  else if (date1.day < date1.day) return -1;

  // debug
  print("valid date");
  return 1;
}

// function to remove event on click
Future<void> removeEvent(String id) async {
  try {
    await FirebaseFirestore.instance.collection("club_events").doc(id).delete();
    print('removed a event with id $id');
  } catch (e) {
    print(e);
  }
}

// function to get list of friends uid
Future<List<String>> getFriendsUid(String uid) async {
  List<String> friendsUid = [];
  try {
    final ref =
        await FirebaseFirestore.instance.collection("friends").doc(uid).get();
    List<dynamic> list = ref.data()['friends'];
    friendsUid = list.cast<String>();
  } catch (e) {
    print(e);
  }
  return friendsUid;
}

Future<void> addFriend(String uid, String friendUid) async {
  try {
    await FirebaseFirestore.instance.collection("friends").doc(uid).update({
      "friends": FieldValue.arrayUnion([friendUid]),
    });
  } catch (e) {
    print(e);
  }
}

Future<List<String>> getUsersUid() async {
  List<String> usersUid = [];
  try {
    final ref = await FirebaseFirestore.instance.collection("users").get();
    ref.docs.forEach((element) {
      usersUid.add(element.id);
    });
  } catch (e) {
    print(e);
  }
  return usersUid;
}

Future<Map<String, String>> getUsersEmail() async {
  Map<String, String> usersEmail = {};
  try {
    final ref = await FirebaseFirestore.instance.collection("users").get();
    ref.docs.forEach((element) {
      usersEmail[element.id] = element.data()['email'];
    });
  } catch (e) {
    print(e);
  }
  return usersEmail;
}

Future<void> addFriendEvent(FriendEvent friendEvent) async {
  try {
    await FirebaseFirestore.instance.collection("friend_event").add(friendEvent.toMap());
  } catch (e) {
    print(e);
  }
}
