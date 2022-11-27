import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menu_dashboard_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Color _backgroundColor = const Color(0xFF343442);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: _backgroundColor,
    statusBarIconBrightness: Brightness.light,
    //systemNavigationBarColor: Colors.pink,
    //systemNavigationBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuDashboard(),
    );
  }
}
