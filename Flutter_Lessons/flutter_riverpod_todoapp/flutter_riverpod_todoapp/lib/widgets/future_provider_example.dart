import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todoapp/models/cat_fact_model.dart';

final httpClientProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://catfact.ninja/'));
});

final catFactsProvider = FutureProvider.autoDispose
    .family<List<CatFactModel>, Map<String, dynamic>>(
        (ref, parameterMap) async {
  final _dio = ref.watch(httpClientProvider);
  // final _result = await _dio.get('facts', queryParameters: {
  //   'limit' : parameterMap['limit'],
  //   'max_length' : parameterMap['max_length']
  // });
  final _result = await _dio.get('facts', queryParameters: parameterMap);
  List<CatFactModel> _catFactList = (_result.data['data'] as List)
      .map((e) => CatFactModel.fromMap(e))
      .toList();

  // ref.keepAlive(); // 2. Açılışta Daha Hızlı Çalışmasını Sağlar.

  return _catFactList;
});

class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Map'den önce const yazmazsak sayfa cevap dönmez. const YAZILMALIDIR.
    var _catFactList =
        ref.watch(catFactsProvider(const {'limit': 6, 'max_length': 30}));
    return Scaffold(
      body: SafeArea(
          child: _catFactList.when(
              data: (list) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index].fact),
                    );
                  },
                  itemCount: list.length,
                );
              },
              error: (err, stack) {
                return Center(
                    child: Text('There Is Error:  ${err.toString()}'));
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))),
    );
  }
}
