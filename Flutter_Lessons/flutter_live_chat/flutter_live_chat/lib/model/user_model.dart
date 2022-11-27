// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseProcessUser {
  final String userId;
  String? email;
  String? userName;
  String? profilURL;
  DateTime? createdAt;
  DateTime? updateAt;
  int? level;

  FirebaseProcessUser({required this.userId, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      'email': email,
      'userName': userName ??
          email!.substring(0, email!.indexOf('@')) + generateRandomNumber(),
      'profilURL': profilURL ??
          'https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updateAt': updateAt ?? FieldValue.serverTimestamp(),
      'level': level ?? 1,
    };
  }

  FirebaseProcessUser.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updateAt = (map['updateAt'] as Timestamp).toDate(),
        level = map['level'];

  FirebaseProcessUser.userIdAndProfilUrl(
      {required this.userId, @required this.profilURL});

  @override
  String toString() {
    return 'FirabaseProcessUser{userId: $userId , email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updateAt: $updateAt, level: $level,  }';
  }

  String generateRandomNumber() {
    int randomNumber = Random().nextInt(999999);
    return randomNumber.toString();
  }
}
