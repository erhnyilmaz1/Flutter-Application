part of 'counter_cubit.dart';

// lib Folder'ı Sağ Click => "Cubit: New Cubit"  => İsim Verilir ve "isim_cubit.dart(isim:counter)" ve "isim_state.dart(isim:counter)" Dosyaları Oluşturulur.

@immutable
abstract class CounterCubitState {
  final int counter;
  const CounterCubitState({required this.counter});
}

class CounterInitial extends CounterCubitState {
  const CounterInitial({required int initialValue})
      : super(counter: initialValue);
}

class MyCounterState extends CounterCubitState {
  const MyCounterState({required int counterValue})
      : super(counter: counterValue);
}
