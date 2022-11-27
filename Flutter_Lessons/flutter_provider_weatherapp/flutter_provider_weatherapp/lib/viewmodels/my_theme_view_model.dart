// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:flutter_provider_weatherapp/models/my_theme.dart';

class MyThemeViewModel extends ChangeNotifier {
  late MyTheme _myTheme;

  MyThemeViewModel() {
    _myTheme = MyTheme(Colors.blue, ThemeData.light());
  }

  MyTheme get myTheme => _myTheme;

  set myTheme(MyTheme value) {
    _myTheme = value;
    notifyListeners(); // Değer Her Değiştiğinde Arayüze Değeri İletir.
  }

  void changeWeather(String weatherAbbreviation) {
    late MyTheme _tempTheme;

    switch (weatherAbbreviation) {
      case 'sn': // Karlı
      case 'sl': // Sulu Kar
      case 'h': // Dolu
      case 't': // Fırtına
      case 'hc': // Çok Bulutlu
        _tempTheme =
            MyTheme(Colors.grey, ThemeData(primaryColor: Colors.blueGrey));
        break;

      case 'hr': // Ağır Yağmurlu
      case 'lr': // Hafif Yağmurlu
      case 's': // Sağanak Yağış
        MyTheme(Colors.indigo, ThemeData(primaryColor: Colors.indigoAccent));
        break;

      case 'lc': // Az Bulutlu
      case 'c': // Açık Güneşli
        MyTheme(Colors.yellow, ThemeData(primaryColor: Colors.orangeAccent));
        break;
    }

    _myTheme = _tempTheme;
  }
}
