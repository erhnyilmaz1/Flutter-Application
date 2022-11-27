import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_lessons/model/counter_model.dart';

class CounterManager extends StateNotifier<CounterModel> {
  // state : CounterModel
  CounterManager() : super(CounterModel(0)); // counter Parametere Initial Value

  void increment() {
    var _currentValue = state.counterValue;
    state = CounterModel(_currentValue + 1);
  }

  void decrement() {
    var _currentValue = state.counterValue;
    state = CounterModel(_currentValue - 1);
  }
}
