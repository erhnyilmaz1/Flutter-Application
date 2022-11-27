// ignore_for_file: unnecessary_null_comparison, avoid_print, await_only_futures, body_might_complete_normally_nullable, unnecessary_null_in_if_null_operators, import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/services/firebase_auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements FirebaseAuthBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseProcessUser?> currentUser() async {
    try {
      // User? user = await _auth.currentUser;
      // print("Current User Value: " + user.toString());
      // return firabaseUserFromUser(user!);
      _auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
    } catch (e) {
      print("CurrentUser Auth Error: " + e.toString());
      return null;
    }
  }

  @override
  Future<FirebaseProcessUser?> signInAnonymously() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      return firabaseUserFromUser(credential.user!);
    } catch (e) {
      print("Sign In Anonymously Error: " + e.toString());
    }
    return null;
  }

  @override
  Future<bool?> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      print("Sign Out Error: " + e.toString());
      return false;
    }
  }

  @override
  Future<FirebaseProcessUser?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    var result = await _auth.signInWithCredential(credential);

    return firabaseUserFromUser(result.user!);
  }

  @override
  Future<FirebaseProcessUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    var credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    var _myUser = credential.user;

    if (!_myUser!.emailVerified) {
      _myUser.sendEmailVerification();
    }

    return firabaseUserFromUser(_myUser);
  }

  @override
  Future<FirebaseProcessUser?> signInWithEmailAndPassword(
      String email, String password) async {
    var credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    var _myUser = credential.user;

    return firabaseUserFromUser(_myUser!);
  }

  FirebaseProcessUser? firabaseUserFromUser(User user) {
    if (user == null) {
      return null;
    }

    return FirebaseProcessUser(userId: user.uid.toString(), email: user.email);
  }
}
