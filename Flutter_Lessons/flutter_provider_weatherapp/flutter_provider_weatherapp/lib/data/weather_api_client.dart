import 'package:flutter_provider_weatherapp/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com";
  final http.Client httpClient = http.Client();

  Future<int> getLocationId(String cityName) async {
    final cityIdUrl = baseUrl + "/api/location/search/?query=$cityName";
    final cityWeatherIdResponse = await httpClient.get(Uri.parse(cityIdUrl));

    if (cityWeatherIdResponse.statusCode != 200) {
      throw Exception('Failed To Fetched City Id');
    }

    final cityWeatherIdJSON = (jsonDecode(cityWeatherIdResponse.body)) as List;

    return cityWeatherIdJSON[0]["woeid"];
  }

  Future<Weather> getCityWeather(int locationId) async {
    final weatherInfoUrl = "/api/location/$locationId/";
    final cityWeatherInfosResponse =
        await httpClient.get(Uri.parse(weatherInfoUrl));

    if (cityWeatherInfosResponse.statusCode != 200) {
      throw Exception('Failed To Fetched City Weather Infos');
    }

    final cityWeatherInfosJSON = jsonDecode(cityWeatherInfosResponse.body);

    return Weather.fromJson(cityWeatherInfosJSON);
  }
}
