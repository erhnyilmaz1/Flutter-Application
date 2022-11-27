import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_lessons/all_providers.dart';

class RiverpodBasics extends StatelessWidget {
  const RiverpodBasics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('MaterialApp Build Was Trigged');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Scaffold Build Was Trigged');
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            var _title = ref.watch(titleProvider);
            return Text(_title);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            MyLabelText(),
            MyCounterText(),
          ],
        ),
      ),
      floatingActionButton: const MyFloatingActionButton(),
    );
  }
}

class MyLabelText extends ConsumerWidget {
  const MyLabelText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('MyLabelText Build Was Trigged');
    return Text(ref.watch(labelProvider));
  }
}

class MyCounterText extends ConsumerWidget {
  const MyCounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('MyCounterText Build Was Trigged');
    var counter = ref.watch(counterStateProvide);
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class MyFloatingActionButton extends ConsumerWidget {
  const MyFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('MyFloatingActionButton Build Was Trigged');
    return FloatingActionButton(
      onPressed: () {
        ref.read(counterStateProvide.state).state++;
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
