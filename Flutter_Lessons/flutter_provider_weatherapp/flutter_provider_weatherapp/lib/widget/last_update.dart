import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weather_view_model.dart';

class LastUpdateWidget extends StatelessWidget {
  const LastUpdateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _weatherViewModel = Provider.of<WeatherViewModel>(context);
    var lastUpdateDate = _weatherViewModel.fetchWeather.time.toLocal();
    return Text(
      'Last Update: ' + TimeOfDay.fromDateTime(lastUpdateDate).format(context),
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
    );
  }
}
