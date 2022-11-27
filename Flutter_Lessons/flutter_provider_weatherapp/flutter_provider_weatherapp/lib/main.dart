import 'package:flutter/material.dart';
import 'package:flutter_provider_weatherapp/locator.dart';
import 'package:flutter_provider_weatherapp/viewmodels/my_theme_view_model.dart';
import 'package:flutter_provider_weatherapp/viewmodels/weather_view_model.dart';
import 'package:flutter_provider_weatherapp/widget/weather_app.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(ChangeNotifierProvider(
      create: (context) => MyThemeViewModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeViewModel>(
      builder: (context, MyThemeViewModel myThemeViewModel, child) =>
          MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: myThemeViewModel.myTheme.theme,
        home: ChangeNotifierProvider(
            create: (context) => locator<WeatherViewModel>(),
            child: WeatherApp()),
      ),
    );
  }
}
