import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod_lessons/riverpod_basics.dart';
import 'package:flutter_riverpod_lessons/state_notifier_provider.dart';

void main() {
  //runApp(const ProviderScope(child: RiverpodBasics()));
  runApp(const ProviderScope(child: StateProviderNotifierUsage()));
  // Provider Kullanımı İçin Widget'ı ProviderScope İçerisine child olarak vermek gerekir.
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const MyLabelText(),
            MyCounterText(
              counter: _counter,
            ),
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(
        onIncrement: () {
          _counter++;
          setState(() {});
        },
      ),
    );
  }
}

class MyLabelText extends StatelessWidget {
  const MyLabelText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'You have pushed the button this many times:',
    );
  }
}

class MyCounterText extends StatelessWidget {
  final int counter;
  const MyCounterText({Key? key, required this.counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  final VoidCallback onIncrement;

  const MyFloatingActionButton({Key? key, required this.onIncrement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onIncrement,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
