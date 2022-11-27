import 'package:flutter_bloc_weatherapp/data/weather_api_client.dart';
import 'package:flutter_bloc_weatherapp/model/weather.dart';

import '../locator.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();
  //WeatherApiClient weatherApiClient = locator.get<WeatherApiClient>();
  Future<Weather> getWaether(String cityName) async {
    final int locationId = await weatherApiClient.getLocationId(cityName);
    return await weatherApiClient.getCityWeather(locationId);
  }
}
