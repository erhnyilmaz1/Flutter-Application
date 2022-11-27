// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FontUsage extends StatelessWidget {
  const FontUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Kişisel Font Kullanımı 2',
        style: TextStyle(
          fontFamily: 'General',
          fontWeight: FontWeight.w700,
          fontSize: 40.0,
        ));
  }
}
