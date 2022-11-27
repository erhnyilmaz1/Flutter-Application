import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foundamental_widget/main.dart';
import 'package:flutter_foundamental_widget/navigator/orangePage.dart';
import 'package:flutter_foundamental_widget/navigator/purplePage.dart';
import 'package:flutter_foundamental_widget/navigator/redPage.dart';
import 'package:flutter_foundamental_widget/navigator/yellowPage.dart';
import 'package:flutter_foundamental_widget/studentDetail.dart';
import 'package:flutter_foundamental_widget/studentList.dart';

class OnGeneratedRoute {
  static Route<dynamic>? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return platformType(MyApp(), settings);
      case "/yellowPage":
        return platformType(YellowPage(), settings);
      case "/redPage":
        return platformType(RedPage(), settings);
      case "/orangePage":
        return platformType(OrangePage(), settings);
      case "/purplePage":
        return platformType(PurplePage(), settings);
      case "/studentList":
        return platformType(StudentList(), settings);
      case "/studentDetail":
        var _selectedStudent = settings.arguments as Student;
        return platformType(
            StudentDetail(
              student: _selectedStudent,
            ),
            settings);
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("404"),
                  ),
                  body: Text("Sayfa Bulunamadı"),
                ));
    }
  }

  static Route<dynamic>? platformType(
      Widget widgetName, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          settings: settings, builder: (context) => widgetName);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
          settings: settings, builder: (context) => widgetName);
    } else {
      return MaterialPageRoute(
          settings: settings, builder: (context) => widgetName);
    }
  }
}
