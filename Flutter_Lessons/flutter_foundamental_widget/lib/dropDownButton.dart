import 'package:flutter/material.dart';

/*
    1.) value:_chooseCity, ==>  ÖN YÜZDE GÖSTERİLEN DEĞERDİR.items İÇERİSİNDEKİ value'LERDEN OLMALIDIR. YOKSA HATA VERİR.
    2.) setState() METODU İLE BUİLD TEKRAR ÇALIŞTIRILIR VE DEĞİŞEN DEĞER ÖN YÜZE GÖSTERİLİR. 
          onChanged: (String? newValue) {
                setState(() {
                  print("Run: $newValue");
                  _chooseCity = newValue;
                });         
*/
class DropDownButtons extends StatefulWidget {
  DropDownButtons({Key? key}) : super(key: key);

  @override
  _DropDownButtonsState createState() => _DropDownButtonsState();
}

class _DropDownButtonsState extends State<DropDownButtons> {
  String? _chooseCity = "";
  List<String> _allCity = [
    "Adıyaman",
    "Ankara",
    "Bursa",
    "İstanbul",
    "İzmir",
    "Van"
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        hint: Text("Choose City"),
        icon: Icon(Icons.arrow_downward),
        style: TextStyle(color: Colors.red),
        underline: Container(
          height: 4,
          color: Colors.purple,
        ),
        /*items: [
          DropdownMenuItem(
            child: Text("İstanbul City"),
            value: "İstanbul",
          ),
          DropdownMenuItem(
            child: Text("Ankara City"),
            value: "Ankara",
          ),
          DropdownMenuItem(
            child: Text("İzmir City"),
            value: "İzmir",
          ),
          DropdownMenuItem(
            child: Text("Bursa City"),
            value: "Bursa",
          ),
        ],*/
        items: _allCity
            .map((String currentValue) => DropdownMenuItem(
                  child: Text(currentValue + " City"),
                  value: currentValue,
                ))
            .toList(),
        value:
            _chooseCity, // Ön Yüzde Gösterilen Değerdir.items İçerisindeki Value'lerden Olmalıdır. Yoksa Hata Verir.
        onChanged: (String? newValue) {
          // setState() Metodu İle build Tekrar Çalıştırılır ve Değişen Değer Ön Yüze Gösterilir.
          setState(() {
            print("Run: $newValue");
            _chooseCity = newValue;
          });
        },
      ),
    );
  }
}
