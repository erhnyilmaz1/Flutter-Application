import 'package:flutter_live_chat/model/user_model.dart';

abstract class FirebaseAuthBase {
  Future<FirebaseProcessUser?> currentUser();
  Future<FirebaseProcessUser?> signInAnonymously();
  Future<bool?> signOut();
  Future<FirebaseProcessUser?> signInWithGoogle();
  Future<FirebaseProcessUser?> signInWithEmailAndPassword(String email, String password);
  Future<FirebaseProcessUser?> createUserWithEmailAndPassword(String email, String password);
}
