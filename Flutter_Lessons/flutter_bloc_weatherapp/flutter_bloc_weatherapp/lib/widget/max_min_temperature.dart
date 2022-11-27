// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_state.dart';

class MaxMinTemperatureWidget extends StatelessWidget {
  const MaxMinTemperatureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder(
      bloc: _weatherBloc,
      //builder: (context, WeatherState state) {
      // contect Yerine _ Yazılabilir.
      builder: (_, WeatherState state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Maximum: ' +
                  (state as WeatherLoadedState)
                      .weather
                      .consolidatedWeather[0]
                      .maxTemp
                      .floor()
                      .toString() +
                  " °C",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Minimum: ' +
                  (state as WeatherLoadedState)
                      .weather
                      .consolidatedWeather[0]
                      .minTemp
                      .floor()
                      .toString() +
                  " °C",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        );
      },
    );
  }
}
