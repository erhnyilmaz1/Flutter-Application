// ignore_for_file: avoid_print

import 'package:flutter_live_chat/model/message.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:http/http.dart' as http;

class SentNotificationService {
  Future<bool> sentNotification(Message saveMessage,
      FirebaseProcessUser? currentUser, String token) async {
    String _endUrl = 'https://fcm.googleapis.com/fcm/send';
    String _firebaseKey =
        'AAAACnk3Hwo:APA91bGEyuRqTmXcTHWEoXb_5U0MCwz7Jb9APalj9S9DTjjvKKlSio0Wozjum7IchiMqcWbcVrxUb-LdXi75VuQRDTwKrWSyzwkAklrJS1771r0fu7y0FaRZonT7zDLi58lg2FCyuN2l';

    Map<String, String> _header = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "key=$_firebaseKey",
    };

    String _jsonBody =
        '{"to": "$token", "data" : {"message" : "${saveMessage.messageContent}", "title" : "${currentUser!.userName} New Message", "profilURL" : "${currentUser.profilURL}" , "senderUserID": "${currentUser.userId}" } }';

    http.Response _response =
        await http.post(Uri.parse(_endUrl), headers: _header, body: _jsonBody);

    if (_response.statusCode == 200) {
      print('Successfull Process');
    } else {
      print(
          'Error Process, Status Code : ${_response.statusCode} , Body: $_jsonBody');
    }

    return true;
  }
}
