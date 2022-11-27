import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_weatherapp/model/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class InitialWeatherState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final Weather weather;
  const WeatherLoadedState({required this.weather});
}

class WeatherErrorState extends WeatherState {}
