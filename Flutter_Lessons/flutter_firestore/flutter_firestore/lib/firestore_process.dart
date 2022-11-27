// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreProcess extends StatelessWidget {
  FireStoreProcess({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore Process'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => addData(), child: const Text('Add Data')),
            ElevatedButton(
              onPressed: () => setData(),
              child: const Text('Set Data'),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  addData() async {
    Map<String, dynamic> _data = <String, dynamic>{};
    _data['name'] = "Erhan";
    _data['age'] = 28;
    _data['isStudent'] = false;
    _data['adress'] = {'province': 'Istanbul', 'district': 'Pendik'};
    _data['properties'] = FieldValue.arrayUnion([
      'blue',
      'green'
    ]); // FieldValue ==> CloudFireStore'da Array ve Timestamp Değerleini Eklemede Yardımcı Olur.
    _data['date'] = FieldValue
        .serverTimestamp(); // FieldValue ==> CloudFireStore'da Array ve Timestamp Değerleini Eklemede Yardımcı Olur.

    await _firestore.collection('users').add(
        _data); // users Diye Collection Yoksa Ekler [users Diye Collection, Yani Klasör Oluşur]. Daha Sonra Bu Klasör Altına Verileri Ekler.
  }

  setData() async {
    var _newDocId = _firestore.collection('users').doc().id;
    debugPrint("Doc Id: " + _newDocId);

    await _firestore.doc('users/$_newDocId').set({
      'school': 'Karadeniz Teknik Üniversitesi',
      'age': FieldValue.increment(1)
    }, SetOptions(merge: true));
    // users Collecton'ı (Klasörü) Altında asdsadasasd Document'e Bakar Ve O Document İçerisindeki Veriye Parametrede Verilen Değeri Yazar. ['school': 'Karadeniz Teknik Üniversitesi']
    //  SetOptions(merge: true)  ==> Document İçerisindeki Diğer Verilerin Yanına Parametrede Verilen Değeri Yazar. ['school': 'Karadeniz Teknik Üniversitesi']
    //  SetOptions(merge: false) veya Bu Parametreyi Vermezsek ==> Document İçerisindeki Diğer Verileri Siler, Sadece Parametrede Verilen Değeri Yazar. ['school': 'Karadeniz Teknik Üniversitesi']
  }
}
