// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_weatherapp/data/weather_repository.dart';
import 'package:flutter_provider_weatherapp/locator.dart';
import 'package:flutter_provider_weatherapp/models/weather.dart';

enum WeatherState {
  InitialWeatherState,
  WeatherLoadingState,
  WeatherLoadedState,
  WeatherErrorState
}

class WeatherViewModel with ChangeNotifier {
  late WeatherState _state;
  final WeatherRepository _weatherRepository = locator<WeatherRepository>();
  late Weather _fetchWeather;

  WeatherViewModel() {
    _fetchWeather = Weather(
        consolidatedWeather: [],
        time: DateTime(2022, 05, 15),
        sunRise: DateTime(2022, 05, 15),
        sunSet: DateTime(2022, 05, 15),
        timezoneName: "",
        parent: Parent(title: "", locationType: "", woeid: 0, lattLong: ""),
        sources: [],
        title: "",
        locationType: "",
        woeid: 0,
        lattLong: "",
        timezone: "");
    _state = WeatherState.InitialWeatherState;
  }

  Weather get fetchWeather => _fetchWeather;

  WeatherState get state => _state;

  set state(WeatherState value) {
    _state = value;
    notifyListeners(); // Değer Her Değiştiğinde Arayüze Değeri İletir.
  }

  Future<Weather> fetchWeatherProcess(String cityName) async {
    try {
      _state = WeatherState.WeatherLoadingState;
      _fetchWeather = await _weatherRepository.getWaether(cityName);
      _state = WeatherState.WeatherLoadedState;
    } catch (e) {
      _state = WeatherState.WeatherErrorState;
    }
    return _fetchWeather;
  }

  Future<Weather> updateWeatherProcess(String cityName) async {
    try {
      _fetchWeather = await _weatherRepository.getWaether(cityName);
      _state = WeatherState.WeatherLoadedState;
    } catch (e) {
      //
    }
    return _fetchWeather;
  }

  String weatherAbbreviation() {
    return fetchWeather.consolidatedWeather[0].weatherStateAbbr;
  }
}
