// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class MyTheme extends ChangeNotifier {
  late MaterialColor _color;
  late ThemeData _theme;

  MyTheme(_color, _theme);

  MaterialColor get color => _color;

  set color(MaterialColor value) {
    _color = value;
  }

  ThemeData get theme => _theme;

  set theme(ThemeData value) {
    _theme = value;
    notifyListeners(); // Değer Her Değiştiğinde Arayüze Değeri İletir.
  }
}
