part of 'counter_bloc.dart';

// lib Folder'ı Sağ Click => "Bloc: New Bloc"  => İsim Verilir ve "isim_bloc.dart(isim:counter)" , "isim_event.dart(isim:counter)"ve "isim_state.dart(isim:counter)" Dosyaları Oluşturulur.
@immutable
abstract class CounterBlocState {
  final int counter;
  const CounterBlocState({required this.counter});
}

class CounterInitial extends CounterBlocState {
  const CounterInitial({required int initialValue})
      : super(counter: initialValue);
}

class MyCounterState extends CounterBlocState {
  const MyCounterState({required int counterValue})
      : super(counter: counterValue);
}
