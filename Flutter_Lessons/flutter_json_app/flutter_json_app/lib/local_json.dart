import 'dart:convert';
import 'package:flutter/material.dart';
import 'model/car_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  String _title = 'Local Json Process';
  late final Future<List<Car>> _futureCarListFill;

  @override
  void initState() {
    super.initState();
    _futureCarListFill = readCarJson();
    /* Aşağıdaki Kodda FloatingActionButton'a Tıklayınca onPressed Metodunda setState Fonksiyonu Çalışır.
       setState Metodu da State   fulWidget'ın build Metodunu Tekrar Çalıştırır.
       build Metodu İçerisinde Yer Alan Scaffold İçerisindeki body'de de Her Seferinde Future Fonksiyonu (Yani readCarJson() Metodunu) Tekrar Çalıştırmamak İçin Bu Metot initState İçerisine Yazılmıştır.

       YANİ HER BUTONA TIKLANDIĞINDA ÇAĞIRMA; SADECE SAYFA İLK AÇILDIĞINDA ÇAĞIR.
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _title = 'Button Clicked';
            });
          },
        ),
        body: FutureBuilder<List<Car>>(
          future: _futureCarListFill,
          initialData: [
            Car(
                carName: 'Ford',
                country: 'United States',
                establishmentYear: 1930,
                model: [
                  Model(
                    modelName: 'Focus',
                    price: 14000,
                    gasoline: false,
                  )
                ])
          ],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Car> carList = snapshot.data!;
              return ListView.builder(
                itemBuilder: (context, index) {
                  Car item = carList[index];
                  return ListTile(
                    title: Text(item.carName),
                    subtitle: Text(item.country),
                    leading: CircleAvatar(
                      child: Text(item.model[0].price.toString()),
                    ),
                  );
                },
                itemCount: carList.length,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Future<List<Car>> readCarJson() async {
    try {
      //await Future.delayed(const Duration(seconds: 5));
      // await Future.delayed(const Duration(seconds: 5), () {
      //   return Future.error('5 saniye sonra hata çıktı.');
      // });

      debugPrint('5 saniyelik işlem başlıyor');

      // await YAZMAZSAN BEKLEMEZ.!
      await Future.delayed(const Duration(seconds: 5), () {
        debugPrint('5 saniyelik işlem bitti.');
      });
      String readData = await DefaultAssetBundle.of(context)
          .loadString('assets/data/cars.json');
      var jsonArray = jsonDecode(readData);
      // debugPrint(readData);
      // debugPrint("***************************************");
      // List carList = jsonArray;
      // debugPrint(carList.toString());
      // debugPrint("***************************************");
      // debugPrint(carList[1]["model"][0]["price"].toString());

      List<Car> allCars =
          (jsonArray as List).map((car) => Car.fromMap(car)).toList();
      debugPrint(allCars.length.toString());
      debugPrint(allCars[1].country.toString());

      return allCars;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
