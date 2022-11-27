// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  Weather({
    required this.consolidatedWeather,
    required this.time,
    required this.sunRise,
    required this.sunSet,
    required this.timezoneName,
    required this.parent,
    required this.sources,
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
    required this.timezone,
  });

  List<ConsolidatedWeather> consolidatedWeather;
  DateTime time;
  DateTime sunRise;
  DateTime sunSet;
  String timezoneName;
  Parent parent;
  List<Source> sources;
  String title;
  String locationType;
  int woeid;
  String lattLong;
  String timezone;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        consolidatedWeather: List<ConsolidatedWeather>.from(
            json["consolidated_weather"]
                .map((x) => ConsolidatedWeather.fromJson(x))),
        time: DateTime.parse(json["time"]),
        sunRise: DateTime.parse(json["sun_rise"]),
        sunSet: DateTime.parse(json["sun_set"]),
        timezoneName:
            json["timezone_name"] == null ? null : json["timezone_name"],
        parent: Parent.fromJson(json["parent"]),
        sources:
            List<Source>.from(json["sources"].map((x) => Source.fromJson(x))),
        title: json["title"] == null ? null : json["title"],
        locationType:
            json["location_type"] == null ? null : json["location_type"],
        woeid: json["woeid"] == null ? null : json["woeid"],
        lattLong: json["latt_long"] == null ? null : json["latt_long"],
        timezone: json["timezone"] == null ? null : json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "consolidated_weather": consolidatedWeather == null
            ? null
            : List<dynamic>.from(consolidatedWeather.map((x) => x.toJson())),
        "time": time == null ? null : time.toIso8601String(),
        "sun_rise": sunRise == null ? null : sunRise.toIso8601String(),
        "sun_set": sunSet == null ? null : sunSet.toIso8601String(),
        "timezone_name": timezoneName == null ? null : timezoneName,
        "parent": parent == null ? null : parent.toJson(),
        "sources": sources == null
            ? null
            : List<dynamic>.from(sources.map((x) => x.toJson())),
        "title": title == null ? null : title,
        "location_type": locationType == null ? null : locationType,
        "woeid": woeid == null ? null : woeid,
        "latt_long": lattLong == null ? null : lattLong,
        "timezone": timezone == null ? null : timezone,
      };
}

class ConsolidatedWeather {
  ConsolidatedWeather({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.windDirectionCompass,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  int id;
  String weatherStateName;
  String weatherStateAbbr;
  String windDirectionCompass;
  DateTime created;
  DateTime applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  int humidity;
  double visibility;
  int predictability;

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      ConsolidatedWeather(
        id: json["id"] == null ? null : json["id"],
        weatherStateName: json["weather_state_name"] == null
            ? null
            : json["weather_state_name"],
        weatherStateAbbr: json["weather_state_abbr"] == null
            ? null
            : json["weather_state_abbr"],
        windDirectionCompass: json["wind_direction_compass"] == null
            ? null
            : json["wind_direction_compass"],
        created: DateTime.parse(json["created"]),
        applicableDate: DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"] == null ? null : json["min_temp"].toDouble(),
        maxTemp: json["max_temp"] == null ? null : json["max_temp"].toDouble(),
        theTemp: json["the_temp"] == null ? null : json["the_temp"].toDouble(),
        windSpeed:
            json["wind_speed"] == null ? null : json["wind_speed"].toDouble(),
        windDirection: json["wind_direction"] == null
            ? null
            : json["wind_direction"].toDouble(),
        airPressure: json["air_pressure"] == null
            ? null
            : json["air_pressure"].toDouble(),
        humidity: json["humidity"] == null ? null : json["humidity"],
        visibility:
            json["visibility"] == null ? null : json["visibility"].toDouble(),
        predictability:
            json["predictability"] == null ? null : json["predictability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "weather_state_name":
            weatherStateName == null ? null : weatherStateName,
        "weather_state_abbr":
            weatherStateAbbr == null ? null : weatherStateAbbr,
        "wind_direction_compass":
            windDirectionCompass == null ? null : windDirectionCompass,
        "created": created == null ? null : created.toIso8601String(),
        "applicable_date": applicableDate == null
            ? null
            : "${applicableDate.year.toString().padLeft(4, '0')}-${applicableDate.month.toString().padLeft(2, '0')}-${applicableDate.day.toString().padLeft(2, '0')}",
        "min_temp": minTemp == null ? null : minTemp,
        "max_temp": maxTemp == null ? null : maxTemp,
        "the_temp": theTemp == null ? null : theTemp,
        "wind_speed": windSpeed == null ? null : windSpeed,
        "wind_direction": windDirection == null ? null : windDirection,
        "air_pressure": airPressure == null ? null : airPressure,
        "humidity": humidity == null ? null : humidity,
        "visibility": visibility == null ? null : visibility,
        "predictability": predictability == null ? null : predictability,
      };
}

class Parent {
  Parent({
    required this.title,
    required this.locationType,
    required this.woeid,
    required this.lattLong,
  });

  String title;
  String locationType;
  int woeid;
  String lattLong;

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        title: json["title"] == null ? null : json["title"],
        locationType:
            json["location_type"] == null ? null : json["location_type"],
        woeid: json["woeid"] == null ? null : json["woeid"],
        lattLong: json["latt_long"] == null ? null : json["latt_long"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "location_type": locationType == null ? null : locationType,
        "woeid": woeid == null ? null : woeid,
        "latt_long": lattLong == null ? null : lattLong,
      };
}

class Source {
  Source({
    required this.title,
    required this.slug,
    required this.url,
    required this.crawlRate,
  });

  String title;
  String slug;
  String url;
  int crawlRate;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        title: json["title"] == null ? null : json["title"],
        slug: json["slug"] == null ? null : json["slug"],
        url: json["url"] == null ? null : json["url"],
        crawlRate: json["crawl_rate"] == null ? null : json["crawl_rate"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "slug": slug == null ? null : slug,
        "url": url == null ? null : url,
        "crawl_rate": crawlRate == null ? null : crawlRate,
      };
}
