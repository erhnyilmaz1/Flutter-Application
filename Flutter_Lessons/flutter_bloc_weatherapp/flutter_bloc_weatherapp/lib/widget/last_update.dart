import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_bloc_weatherapp/blocs/weather/bloc/weather_state.dart';

class LastUpdateWidget extends StatelessWidget {
  const LastUpdateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder(
        bloc: _weatherBloc,
        builder: (context, WeatherState state) {
          var _newDate = (state as WeatherLoadedState).weather.time.toLocal();
          return Text(
            'Last Update: ' + TimeOfDay.fromDateTime(_newDate).format(context),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          );
        });
  }
}
