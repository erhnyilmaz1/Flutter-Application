import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/theme/bloc/theme_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weatherapp/widget/weather_app.dart';

import 'locator.dart';

void main() {
  setupLocator();
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<ThemeBloc>(context),
        builder: (context, ThemeState state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: (state as ThemeApplication).theme,
            home: BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc(),
              child: const WeatherApp(),
            ),
          );
        });
  }
}
