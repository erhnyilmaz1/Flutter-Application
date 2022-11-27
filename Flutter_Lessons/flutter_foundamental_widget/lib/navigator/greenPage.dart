import 'package:flutter/material.dart';

class GreenPage extends StatelessWidget {
  GreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green Page'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Center(
          child: Text(
            'Green Page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
