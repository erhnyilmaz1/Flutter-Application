import 'package:flutter/material.dart';

class PurplePage extends StatelessWidget {
  PurplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purple Page'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Center(
          child: Text(
            'Purple Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
