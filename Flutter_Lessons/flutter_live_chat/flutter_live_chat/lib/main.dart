// ignore_for_file: prefer_is_empty

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/app/landing_page.dart';
//import 'package:flutter_live_chat/firebase_options.dart';
import 'package:flutter_live_chat/locator.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAFh8cYUyYuUj7AtZ_8_h9pq-8Aq22xxdE",
        appId: "1:44983328522:android:0b7aa5acdab95a954b24f3",
        messagingSenderId: "44983328522",
        projectId: "flutterlivechat-66120",
        storageBucket: "flutterlivechat-66120.appspot.com"),
  );

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      // UserModel'i Tüm Class'ların Kullanması İçin (İç İçe Widget'larde Geçen Navigator'ların Bile. Örnek Olarak LoginAndLogonPage Sayfasına Navigate Olurken) Bu Şekilde Yapıldı.
      child: MaterialApp(
        title: 'Flutter Loves',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
