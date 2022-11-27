import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'counter_manager.dart';
import 'model/counter_model.dart';

final titleProvider =
    Provider<String>((ref) => 'Riverpod Provider'); // Provider Usage Method 1
final titleStateNotifierProvider = Provider<String>(
    (ref) => 'Riverpod State Notifier Provider'); // Provider Usage Method 1
final labelProvider = Provider<String>(
  (ref) {
    return 'Click Button Count:';
  },
); // Provider Usage Method 2
final counterStateProvide = StateProvider<int>(
  (ref) {
    return 0;
  },
); // StateProvider Usage Method 1

// 1.Parametre [Örnekte CounterManager] ==> Kodların , Metotların Olduğu Dosyadır.
// Buna Erişebilmek İçin ref.watch(counterStateNotifierProvide.notifier).methodName() Demek Gerekir.

// 2.Parametre [Örnekte CounterModel] ==> Provider'in State'idir.
// Buna Erişebilmek İçin ref.watch(counterStateNotifierProvide) Demek Gerekir.
// Model [Örnekte CounterModel] İçerisindeki Değişkene Aşağıdaki Yöntem İle Erişebiliriz.
// Örnek :  ref.watch(counterStateNotifierProvide).counterValue;
final counterStateNotifierProvide =
    StateNotifierProvider<CounterManager, CounterModel>((ref) {
  return CounterManager();
});

final isOddEvenProvider = Provider<bool>((ref) {
  //watch ==> Her Tetiklendiğinde Kontrol Edilir. Ona Bağlı Provider Değeri Değişirse Etkilenir.
  //read  ==> Sadece Açılışta Kontrol Edilir.  Ona Bağlı Provider Değeri Değişirse Etkilenmez.

  var counterValue = ref.watch(counterStateNotifierProvide);
  return counterValue.counterValue % 2 == 0;
});
