import 'package:firebase_auth/firebase_auth.dart';

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
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
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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
  } on FirebaseAuthException catch(e) {
    print(e);
  }
  return false;
}
