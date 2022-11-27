// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/theme/bloc/theme_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_event.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_state.dart';
import 'package:flutter_bloc_weatherapp/model/weather.dart';
import 'package:flutter_bloc_weatherapp/widget/last_update.dart';
import 'package:flutter_bloc_weatherapp/widget/location.dart';
import 'package:flutter_bloc_weatherapp/widget/max_min_temperature.dart';
import 'package:flutter_bloc_weatherapp/widget/select-city.dart';
import 'package:flutter_bloc_weatherapp/widget/toggle_background_color.dart';
import 'package:flutter_bloc_weatherapp/widget/weather_image.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String userSelectCity = "Istanbul";

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    Completer<void> _refreshCompleter = Completer<void>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () async {
              userSelectCity = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectCityWidget(),
                  ));

              if (userSelectCity != null) {
                _weatherBloc.add(FetchWeatherEvent(cityName: userSelectCity));
                // Eskiden dispatch Olan Metot İsmi Değiştirildi.
              }
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder(
            bloc: _weatherBloc,
            builder: (context, WeatherState state) {
              if (state is InitialWeatherState) {
                return const Center(
                  child: Text('Select A City'),
                );
              }

              if (state is WeatherLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is WeatherLoadedState) {
                final Weather fetchedWeather = state.weather;
                final String weatherAbbr =
                    fetchedWeather.consolidatedWeather[0].weatherStateAbbr;
                userSelectCity = fetchedWeather.title;

                BlocProvider.of<ThemeBloc>(context)
                    .add(ChangeThemeEvent(weatherAbbr: weatherAbbr));

                // Completer'ı Durdurur.
                _refreshCompleter.complete();

                // "Future Already Completer" Hatası Almamak İçin Yeni Completer Oluşturulur.
                _refreshCompleter = Completer();

                // Cihazda Sayfayı Aşağıya Doğru İndirerek Refresh Etmeyi Sağlar.
                // onRefresh Future<void> Döndürmelidir.
                return BlocBuilder(
                    bloc: BlocProvider.of<ThemeBloc>(context),
                    builder: (context, ThemeState state) {
                      return ToggleBackgroundColor(
                        color: (state as ThemeApplication).color,
                        child: RefreshIndicator(
                          onRefresh: () {
                            _weatherBloc.add(
                                RefreshWeatherEvent(cityName: userSelectCity));
                            return _refreshCompleter
                                .future; // Completer'ı Çalıştırır.
                            // Eskiden dispatch Olan Metot İsmi Değiştirildi.
                          },
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: LocationWidget(
                                  selectedCity: fetchedWeather.title,
                                )),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: LastUpdateWidget()),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: WeatherImageWidget()),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(child: MaxMinTemperatureWidget()),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }

              if (state is WeatherErrorState) {
                return const Center(
                  child: Text('Created An Error'),
                );
              }

              return const Text('');
            }),
      ),
    );
  }
}
