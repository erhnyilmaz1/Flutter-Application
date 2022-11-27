import 'dart:async';

import 'package:flutter/cupertino.dart';

class CounterModel {
  int _counter = 30;
  final StreamController<int> _controller = StreamController<int>.broadcast();
  Stream<int> get counterStream => _controller.stream;
  Sink<int> get _counterSink => _controller.sink;

  int initialData() {
    return _counter;
  }

  CounterModel() {
    _counterSink.add(_counter);
    debugPrint('To Sink Was Moved First Value');
  }

  void increment() {
    _counterSink.add(++_counter);
  }

  void decrement() {
    _counterSink.add(--_counter);
  }
}
