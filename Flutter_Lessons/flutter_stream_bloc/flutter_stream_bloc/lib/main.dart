import 'package:flutter/material.dart';
import 'package:flutter_stream_bloc/counter_model.dart';

void main() {
  runApp(const MyApp());
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final CounterModel _counterModel = CounterModel();

  @override
  Widget build(BuildContext context) {
    debugPrint('Trigged Builder');
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          initialData: _counterModel.initialData(),
          stream: _counterModel.counterStream,
          builder: (context, snapshot) {
            return Text(title +
                (snapshot.hasData ? snapshot.data.toString() : 'Not Value'));
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              initialData: _counterModel.initialData(),
              stream: _counterModel.counterStream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData ? snapshot.data.toString() : 'Not Value',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _counterModel.increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              _counterModel.decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
