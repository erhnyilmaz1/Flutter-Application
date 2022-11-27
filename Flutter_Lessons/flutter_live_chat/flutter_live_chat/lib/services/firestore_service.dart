// ignore_for_file: unnecessary_cast, import_of_legacy_library_into_null_safe, unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_live_chat/model/chat.dart';
import 'package:flutter_live_chat/model/message.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/services/firestore_base.dart';

class FirestoreService implements FirestoreBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(FirebaseProcessUser? user) async {
    DocumentSnapshot _readUser =
        await _firestore.doc("users/${user!.userId}").get();

    if (_readUser.data() == null) {
      // There Is Not User
      await _firestore.collection("users").doc(user.userId).set(user.toMap());
      return true;
    } else {
      // There Is User
      return true;
    }
  }

  @override
  Future<FirebaseProcessUser?> readUser(String userId) async {
    var _userDocument = await _firestore.collection("users").doc(userId).get();
    Map<String, dynamic>? _userMap = _userDocument.data();

    FirebaseProcessUser? _user = FirebaseProcessUser.fromMap(_userMap!);
    debugPrint('Read User: ${_user.toString()}');
    return _user;
  }

  @override
  Future<bool> updateUserName(String userId, String newUserName) async {
    var _users = await _firestore
        .collection("users")
        .where('userName', isEqualTo: newUserName)
        .get();

    if (_users.docs.isNotEmpty) {
      return false;
    } else {
      await _firestore
          .collection("users")
          .doc(userId)
          .update({"userName": newUserName});

      return true;
    }
  }

  @override
  Future<bool> updateProfilePhoto(String userId, String profilPhotoURL) async {
    await _firestore
        .collection("users")
        .doc(userId)
        .update({"profilURL": profilPhotoURL});
    return true;
  }

  @override
  Future<List<FirebaseProcessUser?>> getAllUsers() async {
    QuerySnapshot _userDocuments = await _firestore.collection("users").get();

    List<FirebaseProcessUser?> _allUsers = [];
    for (var item in _userDocuments.docs) {
      debugPrint("Read User: ${item.data}");
      Map<String, dynamic>? _userMap = item.data as Map<String, dynamic>?;
      FirebaseProcessUser _user = FirebaseProcessUser.fromMap(_userMap!);
      _allUsers.add(_user);
    }

    // WITH MAP METHOD
    //_allUsers = (_userDocuments.docs as List).map((user) => FirebaseProcessUser.fromMap(user)).toList();

    return _allUsers;
  }

  @override
  Future<List<FirebaseProcessUser?>> getAllUsersFetch(
      FirebaseProcessUser? lastUser, int fetchData) async {
    QuerySnapshot _querySnapshot;
    List<FirebaseProcessUser?> _allUsers = [];
    if (lastUser == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("userName", descending: false)
          .limit(fetchData)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .orderBy("userName", descending: false)
          .startAfter([
            lastUser.userName!
          ]) // PARAMETREDE VERİLEN USER'DAN SONRASINI GETİR.
          .limit(fetchData)
          .get();
      await Future.delayed(const Duration(seconds: 1));
    }

    for (var element in _querySnapshot.docs) {
      FirebaseProcessUser? _itemUser =
          FirebaseProcessUser.fromMap(element.data() as Map<String, dynamic>);
      _allUsers.add(_itemUser);
    }

    return _allUsers;
  }

  @override
  Future<List<Chat?>> getAllConversations(String userId) async {
    var _allConversationsDoc = await _firestore
        .collection("conversations")
        .where("currentUserId", isEqualTo: userId)
        .orderBy("createdDate", descending: true)
        .get();

    List<Chat?> _allConversations = [];

    for (var element in _allConversationsDoc.docs) {
      Chat? _item = Chat.fromMap(element.data());
      _allConversations.add(_item);
    }

    return _allConversations;
  }

  Stream<Message?> getCurrentUserMessageContent(
      String currentUserId, String chatUserId) {
    var _snapshot = _firestore
        .collection("conversations")
        .doc(currentUserId + "--" + chatUserId)
        .collection("messageContent")
        .doc(currentUserId)
        .snapshots();

    return _snapshot
        .map((message) => Message.fromMap(_snapshot as Map<String, dynamic>));
  }

  @override
  Stream<List<Message?>> getOppositeMessage(
      String currentUserId, String chatUserId) {
    var _snapshot = _firestore
        .collection("conversations")
        .doc(currentUserId + "--" + chatUserId)
        .collection("messages")
        .where("conversationOwner", isEqualTo: currentUserId)
        .orderBy("messageDate", descending: true)
        .limit(1)
        .snapshots();

    return _snapshot.map((messageList) =>
        messageList.docs.map((item) => Message.fromMap(item.data())).toList());
  }

  @override
  Future<bool> saveMessage(Message saveMessage) async {
    var _messageId = _firestore.collection("conversations").doc().id;
    var _currentUserDocumentId =
        saveMessage.fromUser! + "--" + saveMessage.toUser!;
    var _chatUserDocumentId =
        saveMessage.toUser! + "--" + saveMessage.fromUser!;

    var _saveMessageMap = saveMessage.toMap();

// Current User Message Save
    await _firestore
        .collection("conversations")
        .doc(_currentUserDocumentId)
        .collection("messageContent")
        .doc(_messageId)
        .set(_saveMessageMap);

    await _firestore
        .collection("conversations")
        .doc(_currentUserDocumentId)
        .set({
      "currentUser": saveMessage.fromUser!,
      "chatUser": saveMessage.toUser!,
      "conversationOwner": saveMessage.conversationOwner!,
      "lastMessage": saveMessage.messageContent!,
      "seenMessage": false,
      "createdDate": FieldValue.serverTimestamp(),
    });

    _saveMessageMap.update("isFromMe", (value) => false);
    _saveMessageMap.update("conversationOwner", (value) => saveMessage.toUser);

// Chat User Message Save
    await _firestore
        .collection("conversations")
        .doc(_chatUserDocumentId)
        .collection("messageContent")
        .doc(_messageId)
        .set(_saveMessageMap);

    await _firestore.collection("conversations").doc(_chatUserDocumentId).set({
      "currentUser": saveMessage.toUser!,
      "chatUser": saveMessage.fromUser!,
      "conversationOwner": saveMessage.conversationOwner!,
      "lastMessage": saveMessage.messageContent!,
      "seenMessage": false,
      "createdDate": FieldValue.serverTimestamp(),
    });

    return true;
  }

  @override
  Future<DateTime> showDateUserId(String userId) async {
    await _firestore
        .collection("server")
        .doc(userId)
        .set({"hour": FieldValue.serverTimestamp()});

    var _readUserDocument =
        await _firestore.collection("server").doc(userId).get();
    Map<String, dynamic> _readUserMap =
        _readUserDocument.data() as Map<String, dynamic>;
    Timestamp _readUserDate = _readUserMap["hour"];

    return _readUserDate.toDate();
  }

  Future<List<Message?>> getAllMessagesFetch(String currentUserId,
      String chatUserId, Message? lastMessage, int fetchData) async {
    QuerySnapshot _querySnapshot;
    List<Message?> _allMessages = [];
    if (lastMessage == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("conversations")
          .doc(currentUserId + "--" + chatUserId)
          .collection("messageContent")
          .where("conversationOwner", isEqualTo: currentUserId)
          .orderBy("messageDate", descending: true)
          .limit(fetchData)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("conversations")
          .doc(currentUserId + "--" + chatUserId)
          .collection("messageContent")
          .where("conversationOwner", isEqualTo: currentUserId)
          .orderBy("messageDate", descending: true)
          .startAfter([
            lastMessage.messageDate!
          ]) // PARAMETREDE VERİLEN USER'DAN SONRASINI GETİR.
          .limit(fetchData)
          .get();
      await Future.delayed(const Duration(seconds: 1));
    }

    for (var element in _querySnapshot.docs) {
      Message? _itemUser =
          Message.fromMap(element.data() as Map<String, dynamic>);
      _allMessages.add(_itemUser);
    }

    return _allMessages;
  }

  Future<String?> bringToken(String? toUser) async {
    DocumentSnapshot _readToken = await _firestore.doc("tokens/$toUser").get();

    if (_readToken != null) {
      var _tokenData = _readToken.data() as Map<String, dynamic>;

      return _tokenData["token"];
    } else {
      return null;
    }
  }
}
