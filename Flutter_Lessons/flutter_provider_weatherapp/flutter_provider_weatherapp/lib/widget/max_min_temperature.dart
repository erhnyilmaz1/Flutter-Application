// ignore_for_file: unnecessary_cast, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_provider_weatherapp/models/weather.dart';

class MaxMinTemperatureWidget extends StatelessWidget {
  MaxMinTemperatureWidget({Key? key, required this.todayValue})
      : super(key: key);
  ConsolidatedWeather todayValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Maximum: ${todayValue.maxTemp.floor().toString()}°C',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'Minimum: ${todayValue.minTemp.floor().toString()}°C',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
