// ignore_for_file: must_be_immutable, unnecessary_null_comparison, use_key_in_widget_constructors
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_provider_weatherapp/viewmodels/my_theme_view_model.dart';
import 'package:flutter_provider_weatherapp/viewmodels/weather_view_model.dart';
import 'package:flutter_provider_weatherapp/widget/last_update.dart';
import 'package:flutter_provider_weatherapp/widget/location.dart';
import 'package:flutter_provider_weatherapp/widget/max_min_temperature.dart';
import 'package:flutter_provider_weatherapp/widget/select-city.dart';
import 'package:flutter_provider_weatherapp/widget/toggle_background_color.dart';
import 'package:flutter_provider_weatherapp/widget/weather_image.dart';
import 'package:provider/provider.dart';

class WeatherApp extends StatelessWidget {
  String _userSelectCity = "Istanbul";
  late WeatherViewModel _weatherViewModel;

  @override
  Widget build(BuildContext context) {
    _weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () async {
              _userSelectCity = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectCityWidget(),
                  ));
              _weatherViewModel.fetchWeatherProcess(_userSelectCity);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Center(
        child: (_weatherViewModel.state == WeatherState.WeatherLoadedState)
            ? const LoadedWeather()
            : (_weatherViewModel.state == WeatherState.WeatherLoadingState)
                ? loadingWeather()
                : (_weatherViewModel.state == WeatherState.WeatherErrorState)
                    ? errorWeather()
                    : const Text('Select A City'),
      ),
    );
  }

  Widget loadingWeather() {
    return const CircularProgressIndicator();
  }

  Widget errorWeather() {
    return const Text('An Error Occurred During The Operation');
  }
}

class LoadedWeather extends StatefulWidget {
  const LoadedWeather({Key? key}) : super(key: key);
  @override
  State<LoadedWeather> createState() => _LoadedWeatherState();
}

class _LoadedWeatherState extends State<LoadedWeather> {
  late WeatherViewModel _weatherViewModel;
  Completer<void> _refreshIndicator = Completer<void>();

  @override
  void initState() {
    super.initState();
    _refreshIndicator = Completer<void>();
    debugPrint('Trigged LoadedWeather InitState');

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      var _weatherAbbreviation =
          Provider.of<WeatherViewModel>(context).weatherAbbreviation();
      debugPrint('Weather Abbreviation: $_weatherAbbreviation');
      Provider.of<MyThemeViewModel>(context)
          .changeWeather(_weatherAbbreviation);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Trigged LoadedWeather Widget Build');

    _weatherViewModel = Provider.of<WeatherViewModel>(context);

    // Refresh İşlemini Bitir, Sonra Veriyi Geri Döndür.
    _refreshIndicator.complete();

    //  "Future Already Completed" Hatasını Almamak İçin Aşğıaki Tanım Yapılır.
    _refreshIndicator = Completer();

    String _userSelectCity = _weatherViewModel.fetchWeather.title;

    return ToggleBackgroundColor(
      color: Provider.of<MyThemeViewModel>(context).myTheme.color,
      child: RefreshIndicator(
        onRefresh: () {
          _weatherViewModel.updateWeatherProcess(_userSelectCity);
          return _refreshIndicator.future;
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: LocationWidget(
                selectedCity: _userSelectCity,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: MaxMinTemperatureWidget(
                      todayValue: _weatherViewModel
                          .fetchWeather.consolidatedWeather[0])),
            ),
          ],
        ),
      ),
    );
  }
}
