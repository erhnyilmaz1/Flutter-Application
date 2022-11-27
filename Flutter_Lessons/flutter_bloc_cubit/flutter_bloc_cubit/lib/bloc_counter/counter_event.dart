part of 'counter_bloc.dart';

// lib Folder'ı Sağ Click => "Bloc: New Bloc"  => İsim Verilir ve "isim_bloc.dart(isim:counter)" , "isim_event.dart(isim:counter)"ve "isim_state.dart(isim:counter)" Dosyaları Oluşturulur.
@immutable
abstract class CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}
