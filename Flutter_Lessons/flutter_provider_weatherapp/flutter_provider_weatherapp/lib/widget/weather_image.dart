// ignore_for_file: unnecessary_cast
import 'package:flutter/material.dart';
import 'package:flutter_provider_weatherapp/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

class WeatherImageWidget extends StatelessWidget {
  const WeatherImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _weatherViewModel = Provider.of<WeatherViewModel>(context);
    return Column(
      children: [
        Text(
          "${_weatherViewModel.fetchWeather.consolidatedWeather[0].theTemp.floor().toString()} °C",
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.network(
          "https://www.metaweather.com/static/img/weather/png/${_weatherViewModel.fetchWeather.consolidatedWeather[0].weatherStateAbbr}.png",
          width: 150,
          height: 150,
        )
      ],
    );
  }
}
