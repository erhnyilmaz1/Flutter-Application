import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_lessons/all_providers.dart';

class StateProviderNotifierUsage extends StatelessWidget {
  const StateProviderNotifierUsage({Key? key}) : super(key: key);

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
            var _title = ref.watch(titleStateNotifierProvider);
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
            IsOddEvenWidget(),
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
    var counter = ref.watch(counterStateNotifierProvide).counterValue;
    return Text(
      '$counter',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class IsOddEvenWidget extends ConsumerWidget {
  const IsOddEvenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('IsOddEvenWdiget Build Was Trigged');
    var currentValue = ref.watch(isOddEvenProvider);
    return Text(currentValue ? 'ÇİFT' : 'TEK');
  }
}

class MyFloatingActionButton extends ConsumerWidget {
  const MyFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('MyFloatingActionButton Build Was Trigged');
    return FloatingActionButton(
      onPressed: () {
        ref.read(counterStateNotifierProvide.notifier).increment();
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
