import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final String selectedCity;
  const LocationWidget({Key? key, required this.selectedCity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      selectedCity,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
