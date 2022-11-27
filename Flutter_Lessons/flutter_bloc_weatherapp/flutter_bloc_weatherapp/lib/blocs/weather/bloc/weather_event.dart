import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;
  const FetchWeatherEvent({required this.cityName});
}

class RefreshWeatherEvent extends WeatherEvent {
  final String cityName;
  const RefreshWeatherEvent({required this.cityName});
}
