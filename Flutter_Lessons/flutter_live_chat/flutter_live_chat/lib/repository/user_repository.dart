// ignore_for_file: constant_identifier_names, body_might_complete_normally_nullable, avoid_print, unnecessary_null_comparison
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/locator.dart';
import 'package:flutter_live_chat/model/chat.dart';
import 'package:flutter_live_chat/model/message.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/services/firebase_auth_base.dart';
import 'package:flutter_live_chat/services/firebase_auth_fake_service.dart';
import 'package:flutter_live_chat/services/firebase_auth_service.dart';
import 'package:flutter_live_chat/services/firestorage_service.dart';
import 'package:flutter_live_chat/services/firestore_service.dart';
import 'package:flutter_live_chat/services/sent_notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;

enum AppMode { DEBUG, RELEASE }

class UserRepository implements FirebaseAuthBase {
  final FirebaseAuthService _firebaseAuthService =
      locator<FirebaseAuthService>();
  final FirebaseAuthFakeService _fakeAuthService =
      locator<FirebaseAuthFakeService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final FirestorageService _firestorageService = locator<FirestorageService>();
  final SentNotificationService _sentNotificationService =
      locator<SentNotificationService>();
  List<FirebaseProcessUser?> _allUsers = [];
  final Map<String, String> _userTokenMap = <String, String>{};

  // UYGULAMA MODUNA GÖRE HANGİ SERVİSİ ÇAĞIRACAĞIMIZ BELİRLENİYOR. DEBUG İSE FAKE SERVİS, RELEASE İSE FİREBASE SERVİS LOCATOR İLE ÇAĞRILIR.
  //AppMode mode = AppMode.DEBUG;
  AppMode mode = AppMode.RELEASE;

  @override
  Future<FirebaseProcessUser?> currentUser() async {
    if (mode == AppMode.DEBUG) {
      return await _fakeAuthService.currentUser();
    } else {
      FirebaseProcessUser? _user = await _firebaseAuthService.currentUser();
      if (_user != null) {
        return await _firestoreService.readUser(_user.userId);
      } else {
        return null;
      }
    }
  }

  @override
  Future<FirebaseProcessUser?> signInAnonymously() async {
    if (mode == AppMode.DEBUG) {
      return await _fakeAuthService.signInAnonymously();
    } else {
      return await _firebaseAuthService.signInAnonymously();
    }
  }

  @override
  Future<bool?> signOut() async {
    if (mode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<FirebaseProcessUser?> signInWithGoogle() async {
    if (mode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithGoogle();
    } else {
      FirebaseProcessUser? _user =
          await _firebaseAuthService.signInWithGoogle();
      if (_user != null) {
        bool _result = await _firestoreService.saveUser(_user);

        if (_result) {
          // Open Session; And Success Save
          return await _firestoreService.readUser(_user.userId);
        } else {
          // Open Session; But Not Success Save
          _firebaseAuthService.signOut();

          return null;
        }
      } else {
        return null;
      }
    }
  }

  @override
  Future<FirebaseProcessUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    if (mode == AppMode.DEBUG) {
      return await _fakeAuthService.createUserWithEmailAndPassword(
          email, password);
    } else {
      FirebaseProcessUser? _user = await _firebaseAuthService
          .createUserWithEmailAndPassword(email, password);
      bool _result = await _firestoreService.saveUser(_user);

      if (_result) {
        return await _firestoreService.readUser(_user!.userId);
      } else {
        return null;
      }
    }
  }

  @override
  Future<FirebaseProcessUser?> signInWithEmailAndPassword(
      String email, String password) async {
    if (mode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithEmailAndPassword(email, password);
    } else {
      FirebaseProcessUser? _readUser = await _firebaseAuthService
          .signInWithEmailAndPassword(email, password);
      return await _firestoreService.readUser(_readUser!.userId);
    }
  }

  Future<bool> updateUserName(String userId, String newUserName) async {
    if (mode == AppMode.DEBUG) {
      return false;
    } else {
      return await _firestoreService.updateUserName(userId, newUserName);
    }
  }

  Future<String> updateFile(
      String userId, String fileType, File profilePhoto) async {
    if (mode == AppMode.DEBUG) {
      return "file_download_link  ";
    } else {
      var _profilPhotoURL =
          await _firestorageService.updateFile(userId, fileType, profilePhoto);

      await _firestoreService.updateProfilePhoto(userId, _profilPhotoURL);

      return _profilPhotoURL;
    }
  }

  Future<List<FirebaseProcessUser?>> getAllUsers() async {
    if (mode == AppMode.DEBUG) {
      return [];
    } else {
      _allUsers = await _firestoreService.getAllUsers();

      return _allUsers;
    }
  }

  Future<List<FirebaseProcessUser?>> getAllUsersFetch(
      FirebaseProcessUser? lastUser, int fetchData) async {
    if (mode == AppMode.DEBUG) {
      return [];
    } else {
      List<FirebaseProcessUser?> _allUsersFetch =
          await _firestoreService.getAllUsersFetch(lastUser, fetchData);
      _allUsers.addAll(_allUsersFetch);
      return _allUsersFetch;
    }
  }

  Future<List<Chat?>> getAllConversations(String userId) async {
    if (mode == AppMode.DEBUG) {
      return [];
    } else {
      DateTime _dateTime = await _firestoreService.showDateUserId(userId);

      List<Chat?> _allConversations =
          await _firestoreService.getAllConversations(userId);

      for (var item in _allConversations) {
        FirebaseProcessUser? _itemUser =
            foundUserInConversationList(item!.chatUserId!);
        if (_itemUser != null) {
          debugPrint("USER READ IN LOCAL CACHE");
          item.chatUserName = _itemUser.userName;
          item.chatUserProfilUrl = _itemUser.profilURL;
        } else {
          debugPrint("USER READ IN DATABASE");
          debugPrint("User Is Not Found. Please Connect To Database");
          var _readUserInDatabase =
              await _firestoreService.readUser(item.chatUserId!);
          item.chatUserName = _readUserInDatabase!.userName;
          item.chatUserProfilUrl = _readUserInDatabase.profilURL;
        }

        _timeagoCalculate(item, _dateTime);
      }

      return _allConversations;
    }
  }

  Stream<List<Message?>> getOppositeMessage(
      String currentUserId, String chatUserId) {
    if (mode == AppMode.DEBUG) {
      return const Stream.empty();
    } else {
      Stream<List<Message?>> _currentChatUserMessageContent =
          _firestoreService.getOppositeMessage(currentUserId, chatUserId);

      return _currentChatUserMessageContent;
    }
  }

  Future<List<Message?>> getAllMessagesFetch(String currentUserId,
      String chatUserId, Message? lastMessage, int fetchData) async {
    if (mode == AppMode.DEBUG) {
      return [];
    } else {
      return _firestoreService.getAllMessagesFetch(
          currentUserId, chatUserId, lastMessage, fetchData);
    }
  }

  Future<bool> saveMessage(
      Message saveMessage, FirebaseProcessUser? currentUser) async {
    if (mode == AppMode.DEBUG) {
      return true;
    } else {
      var dbWriteProcess = await _firestoreService.saveMessage(saveMessage);

      if (dbWriteProcess) {
        var _token = "";
        if (_userTokenMap.containsKey(saveMessage.toUser)) {
          _token = _userTokenMap[saveMessage.toUser]!;
          print('Lokal Token $_token');
        } else {
          _token = (await _firestoreService.bringToken(saveMessage.toUser!))!;
          if (_token != null) {
            _userTokenMap[saveMessage.toUser!] = _token;
            print('Database Token $_token');
          }
        }

        if (_token != null) {
          await _sentNotificationService.sentNotification(
              saveMessage, currentUser, _token);
        }

        return true;
      } else {
        return false;
      }
    }
  }

  FirebaseProcessUser? foundUserInConversationList(String userId) {
    for (int i = 0; i < _allUsers.length; i++) {
      if (_allUsers[i]!.userId == userId) {
        return _allUsers[i];
      }
    }

    return null;
  }

  void _timeagoCalculate(Chat item, DateTime dateTime) {
    item.lastReadTime = dateTime;

    timeago.setLocaleMessages("tr", timeago.TrMessages());
    var _duration = dateTime.difference(item.createdDate!.toDate());
    item.timeDifference =
        timeago.format(dateTime.subtract(_duration), locale: "tr");
  }
}
