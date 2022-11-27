import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

// lib Folder'ı Sağ Click => "Bloc: New Bloc"  => İsim Verilir ve "isim_bloc.dart(isim:counter)" , "isim_event.dart(isim:counter)"ve "isim_state.dart(isim:counter)" Dosyaları Oluşturulur.
class CounterBloc extends Bloc<CounterEvent, CounterBlocState> {
  CounterBloc() : super(const CounterInitial(initialValue: 60)) {
    on<IncrementCounterEvent>((event, emit) {
      emit(MyCounterState(counterValue: state.counter + 1));
    });

    on<DecrementCounterEvent>((event, emit) {
      emit(MyCounterState(counterValue: state.counter - 1));
    });
  }
}
