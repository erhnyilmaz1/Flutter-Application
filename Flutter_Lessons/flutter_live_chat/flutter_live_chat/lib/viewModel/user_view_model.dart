// ignore_for_file: constant_identifier_names, unnecessary_getters_setters
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/locator.dart';
import 'package:flutter_live_chat/model/chat.dart';
import 'package:flutter_live_chat/model/message.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/repository/user_repository.dart';
import 'package:flutter_live_chat/services/firebase_auth_base.dart';

enum ViewState { IDLE, ERROR, LOADED, BUSY }

class UserViewModel with ChangeNotifier implements FirebaseAuthBase {
  ViewState _state = ViewState.IDLE;
  final UserRepository _userRepository = locator<UserRepository>();
  FirebaseProcessUser? _user;
  String emailErrorMessage = "";
  String passwordErrorMessage = "";

  FirebaseProcessUser? get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners(); // HER SET İŞLEMİNDE YAPILMALIDIR. YOKSA HATA ALIR. (SETSTATE GİBİ İŞLEV GÖRÜR.)
  }

  UserViewModel() {
    currentUser();
  }

  @override
  Future<FirebaseProcessUser?> currentUser() async {
    try {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.BUSY;
      _user = await _userRepository.currentUser();
      if (_user != null) {
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("CurrentUser Error In UserModel " + e.toString());
      return null;
    } finally {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.IDLE;
    }
  }

  @override
  Future<FirebaseProcessUser?> signInAnonymously() async {
    try {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.BUSY;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("signInAnonymously Error In UserModel " + e.toString());
      return null;
    } finally {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.IDLE;
    }
  }

  @override
  Future<bool?> signOut() async {
    try {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.BUSY;
      bool? result = await _userRepository.signOut();
      _user = null;
      return result;
    } catch (e) {
      debugPrint("signOut Error In UserModel " + e.toString());
      return false;
    } finally {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.IDLE;
    }
  }

  @override
  Future<FirebaseProcessUser?> signInWithGoogle() async {
    try {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.BUSY;
      _user = await _userRepository.signInWithGoogle();
      if (_user != null) {
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("signInWithGoogle Error In UserModel " + e.toString());
      return null;
    } finally {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.IDLE;
    }
  }

  @override
  Future<FirebaseProcessUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
        // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
        state = ViewState.BUSY;
        _user = await _userRepository.createUserWithEmailAndPassword(
            email, password);
        return _user;
      } else {
        return null;
      }
    } finally {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.IDLE;
    }
  }

  @override
  Future<FirebaseProcessUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
        // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
        state = ViewState.BUSY;
        _user =
            await _userRepository.signInWithEmailAndPassword(email, password);
        return _user;
      } else {
        return null;
      }
    } finally {
      // Set Metoduna Atandı Ve Bu Şekilde notifyListeners Metodu Çağrılarak Değişiklik Algılandı.
      state = ViewState.IDLE;
    }
  }

  Future<bool> updateUserName(String userId, String newUserName) async {
    var _result = await _userRepository.updateUserName(userId, newUserName);

    if (_result) {
      _user!.userName = newUserName;
    }

    return _result;
  }

  Future<String> updateFile(
      String userId, String fileType, File profilePhoto) async {
    var _downloadLink =
        await _userRepository.updateFile(userId, fileType, profilePhoto);
    return _downloadLink;
  }

  Future<List<FirebaseProcessUser?>> getAllUsers() async {
    var _allUsers = await _userRepository.getAllUsers();
    return _allUsers;
  }

  Future<List<FirebaseProcessUser?>> getAllUsersFetch(
      FirebaseProcessUser? lastUser, int fetchData) async {
    var _fetchUsers =
        await _userRepository.getAllUsersFetch(lastUser, fetchData);
    return _fetchUsers;
  }

  Future<List<Chat?>> getAllConversations(String userId) async {
    var _allConversations = await _userRepository.getAllConversations(userId);
    return _allConversations;
  }

  Stream<List<Message?>> getOppositeMessage(
      String currentUserId, String chatUserId) {
    var _currentChatUserMessageContent =
        _userRepository.getOppositeMessage(currentUserId, chatUserId);
    return _currentChatUserMessageContent;
  }

  bool _emailPasswordControl(String email, String password) {
    var result = true;

    if (password.length < 6) {
      passwordErrorMessage = "Password Length Is Less Than 6";
      result = false;
    } else {
      passwordErrorMessage = "";
    }

    if (email.contains('@')) {
      emailErrorMessage = "Invalid Email Address";
      result = false;
    } else {
      emailErrorMessage = "";
    }

    return result;
  }
}
