// ignore_for_file: void_checks
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_event.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_state.dart';
import 'package:flutter_bloc_weatherapp/data/weather_repository.dart';
import 'package:flutter_bloc_weatherapp/locator.dart';
import 'package:flutter_bloc_weatherapp/model/weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository = locator<WeatherRepository>();
  //WeatherRepository weatherRepository = locator.get<WeatherRepository>();
  WeatherBloc() : super(InitialWeatherState()) {
    on<WeatherEvent>((event, emit) async* {
      if (event is FetchWeatherEvent) {
        yield WeatherLoadingState();

        try {
          final Weather fetchedWeather =
              await weatherRepository.getWaether(event.cityName);
          yield WeatherLoadedState(weather: fetchedWeather);
          //} catch (e) {
          // catch İçerisinde e Yerine _ Yazılabilir.
        } catch (_) {
          yield WeatherErrorState();
        }
      } else if (event is RefreshWeatherEvent) {
        try {
          final Weather fetchedWeather =
              await weatherRepository.getWaether(event.cityName);
          yield WeatherLoadedState(weather: fetchedWeather);
          //} catch (e) {
          // catch İçerisinde e Yerine _ Yazılabilir.
        } catch (_) {
          yield state;
        }
      }
    });
  }
}
