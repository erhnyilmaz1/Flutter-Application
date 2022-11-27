import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/services/firebase_auth_base.dart';

class FirebaseAuthFakeService implements FirebaseAuthBase {
  final String userId = "ERHAN";

  @override
  Future<FirebaseProcessUser?> currentUser() async {
    return await Future.value(FirebaseProcessUser(userId: userId, email:"fakeuser@fake.com"));
  }

  @override
  Future<FirebaseProcessUser?> signInAnonymously() async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () {
        return Future.value(FirebaseProcessUser(userId: userId, email:"fakeuser@fake.com"));
      },
    );
  }

  @override
  Future<bool?> signOut() async {
    return await Future.value(true);
  }

  @override
  Future<FirebaseProcessUser?> signInWithGoogle() async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () {
        return Future.value(FirebaseProcessUser(
            userId: "google_user_id_erhan_yilmaz", email:"fakeuser@fake.com"));
      },
    );
  }

  @override
  Future<FirebaseProcessUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () {
        return Future.value(FirebaseProcessUser(
            userId: "create_user_id_erhan_yilmaz", email:"fakeuser@fake.com"));
      },
    );
  }

  @override
  Future<FirebaseProcessUser?> signInWithEmailAndPassword(
      String email, String password) async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () {
        return Future.value(FirebaseProcessUser(
            userId: "signIn_user_id_erhan_yilmaz", email:"fakeuser@fake.com"));
      },
    );
  }
}
