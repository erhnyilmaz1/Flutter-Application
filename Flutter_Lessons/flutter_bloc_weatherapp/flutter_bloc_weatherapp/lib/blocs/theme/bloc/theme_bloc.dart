import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeApplication(
          theme: ThemeData.light(),
          color: Colors.blue,
        )) {
    // ignore: void_checks
    on<ThemeEvent>((event, emit) async* {
      ThemeApplication _themeApplication = ThemeApplication(
        theme: ThemeData.light(),
        color: Colors.blue,
      );
      if (event is ChangeThemeEvent) {
        switch (event.weatherAbbr) {
          case 'sn': // Karlı
          case 'sl': // Sulu Kar
          case 'h': // Dolu
          case 't': // Fırtına
          case 'hc': // Çok Bulutlu
            _themeApplication = ThemeApplication(
                theme: ThemeData(primaryColor: Colors.blueGrey),
                color: Colors.grey);
            break;

          case 'hr': // Ağır Yağmurlu
          case 'lr': // Hafif Yağmurlu
          case 's': // Sağanak Yağış
            _themeApplication = ThemeApplication(
                theme: ThemeData(primaryColor: Colors.indigoAccent),
                color: Colors.indigo);
            break;

          case 'lc': // Az Bulutlu
          case 'c': // Açık Güneşli
            _themeApplication = ThemeApplication(
                theme: ThemeData(primaryColor: Colors.orangeAccent),
                color: Colors.yellow);
            break;
        }
        yield _themeApplication;
      }
    });
  }
}
