import 'package:flutter_live_chat/model/chat.dart';
import 'package:flutter_live_chat/model/message.dart';
import 'package:flutter_live_chat/model/user_model.dart';

abstract class FirestoreBase {
  Future<bool> saveUser(FirebaseProcessUser? user);
  Future<FirebaseProcessUser?> readUser(String userId);
  Future<bool> updateUserName(String userId, String newUserName);
  Future<bool> updateProfilePhoto(String userId, String profilPhotoURL);
  Future<List<FirebaseProcessUser?>> getAllUsers();
  Future<List<FirebaseProcessUser?>> getAllUsersFetch(
      FirebaseProcessUser? lastUser, int fetchData);
  Future<List<Chat?>> getAllConversations(String userId);
  Stream<List<Message?>> getOppositeMessage(
      String currentUserId, String chatUserId);
  Future<bool> saveMessage(Message saveMessage);
  Future<DateTime> showDateUserId(String userId);
}
