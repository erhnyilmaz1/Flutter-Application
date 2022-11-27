// ignore_for_file: avoid_print
import 'dart:convert';
//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/app/conversation.dart';
import 'package:flutter_live_chat/common_widget/platform_sensitive_alert_dialog.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/viewModel/chat_view_model.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:http/http.dart' as http;
//import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    // Handle Data Message
    final dynamic data = message.data;
    print('Background Data : ${data.toString()}');
    NotificationHandler.showNotification(data);
  }
  return Future<void>.value();
}

class NotificationHandler {
  static final NotificationHandler _singleton = NotificationHandler._internal();
  factory NotificationHandler() {
    return _singleton;
  }
  NotificationHandler._internal();
  late BuildContext myContext;

  initializeFCMNotification(BuildContext context) async {
    myContext = context;

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    // await FirebaseMessaging.instance.subscribeToTopic("messages");

    // String? _token = await FirebaseMessaging.instance.getToken();
    // print('Token : $_token');

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      User? _currentUser = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .doc("tokens/${_currentUser.uid}")
          .set({'token': newToken});
    });

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage Trigged: ${message.data}");
      showNotification(message.data);
    });

    // onLaunch : Workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('onLaunch Trigged: ${message!.data}');
    });

    // onResume: Replacement for onResume: When the app is in the background and opened directly from the push notification.
    // UYGULAMA BACKGROUND'DA(UYGULAMA KAPALI; AMA ARKAPLANDA AÇIK ) İSE
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('onResume Trigged: ${message.data}');
      await PlatformSensitiveAlertDialog(
              title: message.data['title'],
              //content: message.data['body'],
              content: message.data['message'], // message Propery In Postman
              mainButtonText: 'OK')
          .show(context);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static void showNotification(Map<String, dynamic> message) async {
    //var _userURLPath = await _downloadAndSaveImage(message['data']['profilURL'], 'largeIcon');

    var _message = Person(
      name: message['data']['title'],
      key: "1",
      //icon: _userURLPath,
    );

    var _messageStyle = MessagingStyleInformation(_message, messages: [
      Message(message['data']['message'], DateTime.now(), _message)
    ]);

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('1234', 'New Message  ',
            channelDescription: 'your channel description',
            styleInformation: _messageStyle,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message['data']['title'],
        message['data']['message'], platformChannelSpecifics,
        payload: jsonEncode(message));
  }

  Future<void> onSelectNotification(String? payload) async {
    final _userViewModel = Provider.of<UserViewModel>(myContext);

    if (payload != null) {
      debugPrint('Notification Payload : $payload');

      Map<String, dynamic> _incomingNotification = await jsonDecode(payload);

      Navigator.of(myContext, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => ChatViewModel(
            currentUser: _userViewModel.user!,
            chatUser: FirebaseProcessUser.userIdAndProfilUrl(
                userId:
                    _incomingNotification['data']['senderUserID']!.chatUserId!,
                profilURL: _incomingNotification['data']['profilURL']!),
          ),
          child: const Conversation(),
        ),
      ));
    }
    return Future<void>.value();
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    return Future<void>.value();
  }

  // static _downloadAndSaveImage(String url, String name) async {
  //   var directory = await getApplicationDocumentsDirectory();
  //   var filePath = '${directory.path}/$name';
  //   var response = await http.get(Uri.parse(url));
  //   var file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);

  //   return filePath;
  // }
}
