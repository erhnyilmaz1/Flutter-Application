// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_state.dart';

class WeatherImageWidget extends StatelessWidget {
  const WeatherImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder(
      bloc: _weatherBloc,
      builder: (context, WeatherState state) {
        return Column(
          children: [
            Text(
              (state as WeatherLoadedState)
                      .weather
                      .consolidatedWeather[0]
                      .theTemp
                      .floor()
                      .toString() +
                  " °C",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
              "https://www.metaweather.com/static/img/weather/${(state as WeatherLoadedState).weather.consolidatedWeather[0].weatherStateAbbr}.svg",
              width: 150,
              height: 150,
            )
          ],
        );
      },
    );
  }
}
