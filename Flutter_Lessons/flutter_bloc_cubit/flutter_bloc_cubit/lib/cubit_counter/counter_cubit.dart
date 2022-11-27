import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

// lib Folder'ı Sağ Click => "Cubit: New Cubit"  => İsim Verilir ve "isim_cubit.dart(isim:counter)" ve "isim_state.dart(isim:counter)" Dosyaları Oluşturulur.
class CounterCubit extends Cubit<CounterCubitState> {
  CounterCubit() : super(const CounterInitial(initialValue: 20));

  void increment() {
    // state.counter , CounterState class^'i İçerisindedir. CounterState class'ı da abstract olduğundan abstract classlarda nesne üretilemez.
    // Bu durumdan dolayı somut class olan MyCounterState Class'dan Nesne Üretilir.
    emit(MyCounterState(counterValue: state.counter + 1));
  }

  void decrement() {
    // state.counter , CounterState class^'i İçerisindedir. CounterState class'ı da abstract olduğundan abstract classlarda nesne üretilemez.
    // Bu durumdan dolayı somut class olan MyCounterState Class'dan Nesne Üretilir.
    emit(MyCounterState(counterValue: state.counter - 1));
  }
}
