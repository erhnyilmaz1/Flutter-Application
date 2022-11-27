// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? fromUser;
  final String? toUser;
  final String? conversationOwner;
  final bool? isFromMe;
  final String? messageContent;
  final Timestamp? messageDate;

  Message(
      {this.fromUser,
      this.toUser,
      this.conversationOwner,
      this.isFromMe,
      this.messageContent,
      this.messageDate});

  Map<String, dynamic> toMap() {
    return {
      "fromUser": fromUser,
      "toUser": toUser,
      "conversationOwner": conversationOwner,
      "isFromMe": isFromMe,
      "messageContent": messageContent,
      "messageDate": messageDate ?? FieldValue.serverTimestamp()
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : fromUser = map["fromUser"],
        toUser = map["toUser"],
        conversationOwner = map["conversationOwner"],
        isFromMe = map["isFromMe"],
        messageContent = map["messageContent"],
        messageDate = map["messageDate"];

  @override
  String toString() {
    return 'Message{fromUser : $fromUser,toUser : $toUser, conversationOwner : $conversationOwner, isFromMe : $isFromMe,messageContent : $messageContent,messageDate : $messageDate,}';
  }
}
