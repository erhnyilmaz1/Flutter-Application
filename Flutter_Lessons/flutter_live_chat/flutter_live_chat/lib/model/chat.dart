// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String? currentUserId;
  final String? chatUserId;
  final String? lastMessage;
  final bool? seenMessage;
  final Timestamp? createdDate;
  final Timestamp? seenDate;
  String? chatUserName;
  String? chatUserProfilUrl;
  DateTime? lastReadTime;
  String? timeDifference;

  Chat(this.currentUserId, this.chatUserId, this.lastMessage, this.seenMessage,
      this.createdDate, this.seenDate);

  Map<String, dynamic> toMap() {
    return {
      "currentUserId": currentUserId,
      "chatUserId": chatUserId,
      "lastMessage": lastMessage,
      "seenMessage": seenMessage,
      "createdDate": createdDate ?? FieldValue.serverTimestamp(),
      "seenDate": seenDate,
      "chatUserName": chatUserName,
      "chatUserProfilUrl": chatUserProfilUrl,
      "lastReadTime": lastReadTime,
      "timeDifference": timeDifference,
    };
  }

  Chat.fromMap(Map<String, dynamic> map)
      : currentUserId = map["currentUserId"],
        chatUserId = map["chatUserId"],
        lastMessage = map["lastMessage"],
        seenMessage = map["seenMessage"],
        createdDate = map["createdDate"],
        seenDate = map["seenDate"],
        chatUserName = map["chatUserName"],
        chatUserProfilUrl = map["chatUserProfilUrl"],
        lastReadTime = map["lastReadTime"],
        timeDifference = map["timeDifference"];

  @override
  String toString() {
    return "Chat{currentUserId : $currentUserId,chatUserId : $chatUserId,lastMessage : $lastMessage,seenMessage : $seenMessage,createdDate : $createdDate,seenDate : $seenDate,chatUserName : $chatUserName,chatUserProfilUrl : $chatUserProfilUrl, lastReadTime: $lastReadTime, timeDifference:$timeDifference}";
  }
}
