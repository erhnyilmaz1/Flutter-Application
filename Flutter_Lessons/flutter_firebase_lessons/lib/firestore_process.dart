// ignore_for_file: must_be_immutable, avoid_function_literals_in_foreach_calls, prefer_adjacent_string_concatenation

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreProcess extends StatelessWidget {
  FireStoreProcess({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late StreamSubscription _collectionDocChangesSubscribe;
  late StreamSubscription _collectionDocsSubscribe;
  late StreamSubscription _documentSubscribe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore Process'),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => addData(), child: const Text('Add Data')),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => setData(),
                  child: const Text('Set Data'),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => updateData(),
                  child: const Text('Update Data',
                      style: TextStyle(color: Colors.green)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => deleteData(),
                  child: const Text('Delete Data'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => selectOneTime(),
                  child: const Text('Select One Time'),
                  style: ElevatedButton.styleFrom(primary: Colors.pink),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => selectRealTimeCollectionDocChanges(),
                  child: const Text('Select Real Time Collection Doc Changes'),
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => selectRealTimeCollectionDocs(),
                  child: const Text('Select Real Time Collection Doc'),
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => selectRealTimeDocument(),
                  child: const Text('Select Real Time Document'),
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => streamStop(),
                  child: const Text('Stream Stop'),
                  style: ElevatedButton.styleFrom(primary: Colors.teal),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => batchInsert(),
                  child: const Text('Batch Insert'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => batchUpdate(),
                  child: const Text('Batch Update'),
                  style:
                      ElevatedButton.styleFrom(primary: Colors.blue.shade100),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => batchDelete(),
                  child: const Text('Batch Delete'),
                  style:
                      ElevatedButton.styleFrom(primary: Colors.blue.shade200),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => transactionProcess(),
                  child: const Text('Transaction Process'),
                  style: ElevatedButton.styleFrom(primary: Colors.brown),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => queryingData(),
                  child: const Text('Query Data'),
                  style: ElevatedButton.styleFrom(primary: Colors.cyan),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () => cameraImageUpload(),
                  child: const Text('Camera Image Upload'),
                  style:
                      ElevatedButton.styleFrom(primary: Colors.cyan.shade800),
                ),
              ],
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

    // Yeni Document Yazma
    await _firestore
        .doc('users/$_newDocId')
        .set({'name': 'Erhan', 'userId': _newDocId});

    // Var Olan Document'i Güncelleme
    await _firestore.doc('users/grC94tCoc0W8prnRf0Qd').set({
      'school': 'Karadeniz Teknik Üniversitesi',
      'age': FieldValue.increment(1)
    }, SetOptions(merge: true));
    // users Collecton'ı (Klasörü) Altında asdsadasasd Document'e Bakar Ve O Document İçerisindeki Veriye Parametrede Verilen Değeri Yazar. ['school': 'Karadeniz Teknik Üniversitesi']
    //  SetOptions(merge: true)  ==> Document İçerisindeki Diğer Verilerin Yanına Parametrede Verilen Değeri Yazar. ['school': 'Karadeniz Teknik Üniversitesi']
    //  SetOptions(merge: false) veya Bu Parametreyi Vermezsek ==> Document İçerisindeki Diğer Verileri Siler, Sadece Parametrede Verilen Değeri Yazar. ['school': 'Karadeniz Teknik Üniversitesi']
  }

  updateData() async {
    // set işleminde document değeri ,collection içerisinde olmak zorunda değildir. Olmazsa collection içerisine yeni document oluşturur.
    // update işleminde document değeri ,collection içerisinde olmak zorundadır. Olmazsa Unhandled Ezception "Document Not Found" hatası fırlatır.
    // update işleminde document'i güncelleyeceğiniz key, document içerisinde yoksa o key document'e eklenir.
    // Map Değeri Güncelleme : propertyName.keyName = newValue   Örnek : _fireStore.doc('users/grC94tCoc0W8prnRf0Qd').update({'adres.district' : 'Kurtköy'});
    // Update içerisinde Delete işlemi de yapılır.               Örnek : _firestore.doc('users/grC94tCoc0W8prnRf0Qd').update({'school': FieldValue.delete()});

    await _firestore
        .doc('users/grC94tCoc0W8prnRf0Qd')
        .update({'isStudent': true}); // Exist Key
    await _firestore
        .doc('users/grC94tCoc0W8prnRf0Qd')
        .update({'job': 'Computer Engineer'}); // Not Exist Key
    await _firestore
        .doc('users/grC94tCoc0W8prnRf0Qd')
        .update({'adress.district': 'Kurtköy'}); // Map Data Update
    await _firestore
        .doc('users/grC94tCoc0W8prnRf0Qd')
        .update({'school': FieldValue.delete()}); //  Update Document Delete Key
  }

  deleteData() async {
    await _firestore.doc('users/grC94tCoc0W8prnRf0Qd').delete();
  }

  selectOneTime() async {
    // Collection Sorgusu Sayfa Açılışında Çekilir Ve Değerler Değişmez.
    var _usersDocuments = await _firestore.collection('users').get();
    debugPrint('Users Document Size: ${_usersDocuments.size}');
    debugPrint('Users Document Size: ${_usersDocuments.docs.length}');

    for (var item in _usersDocuments.docs) {
      debugPrint('Document Id: ${item.id}');
      Map _userMap = item.data();
      debugPrint('Document User Name: ${_userMap['name']}');
    }

    var _userErhanDocument =
        await _firestore.doc('users/rKbH4CWMbPvBfAUQTGGb').get();
    var _userErhanDistrict =
        _userErhanDocument['adress']['district'].toString();
    debugPrint('User Erhan District: $_userErhanDistrict');
  }

  selectRealTimeCollectionDocChanges() async {
    // RealTime'da 1 Document Alanını Güncellersen Güncellenen Document'ın Sadece Güncellenen Alanı Değil Tüm Alanları Gelir. Yani Kısmi Güncelleme Yoktur.
    var _userCollectionDocChangesStream =
        _firestore.collection('users').snapshots();

    _collectionDocChangesSubscribe =
        _userCollectionDocChangesStream.listen((event) {
      // Değişen Document'leri Listeler.
      event.docChanges.forEach((element) {
        debugPrint(element.doc.data().toString());
      });
    });
  }

  selectRealTimeCollectionDocs() async {
    // RealTime'da 1 Document Alanını Güncellersen Güncellenen Document'ın Sadece Güncellenen Alanı Değil Tüm Alanları Gelir. Yani Kısmi Güncelleme Yoktur.
    var _userCollectionDocsStream = _firestore.collection('users').snapshots();

    _collectionDocsSubscribe = _userCollectionDocsStream.listen((event) {
      // Tüm Document'leri Listeler.
      event.docs.forEach((element) {
        debugPrint(element.data().toString());
      });
    });
  }

  selectRealTimeDocument() async {
    var _userDocumentStream =
        _firestore.doc('users/rKbH4CWMbPvBfAUQTGGb').snapshots();

    _documentSubscribe = _userDocumentStream.listen((event) {
      debugPrint(event.data().toString());
    });
  }

  streamStop() async {
    await _collectionDocChangesSubscribe.cancel();
    await _collectionDocsSubscribe.cancel();
    await _documentSubscribe.cancel();
  }

  batchInsert() async {
    // Batch ve Transaction Kavramları Ya Hep Ya Hiç Mantığı İle Çalışır. Ya Tüm Datalar İşlem Görür; Ya Da Hiçbir Data İşlem Görmez.
    // 1 Batch İşlemde Maksimum 500 İşlem Yapılır.
    WriteBatch _batch = _firestore.batch();
    CollectionReference _counterCollection = _firestore.collection('counter');

    for (var i = 0; i < 100; i++) {
      var _newDoc = _counterCollection.doc();
      _batch.set(_newDoc, {'count': ++i, 'docId': _newDoc.id});
    }

    await _batch.commit();
  }

  batchUpdate() async {
    // Batch ve Transaction Kavramları Ya Hep Ya Hiç Mantığı İle Çalışır. Ya Tüm Datalar İşlem Görür; Ya Da Hiçbir Data İşlem Görmez.
    // 1 Batch İşlemde Maksimum 500 İşlem Yapılır.
    WriteBatch _batch = _firestore.batch();
    CollectionReference _counterCollection = _firestore.collection('counter');

    var _counterDoc = await _counterCollection.get();

    _counterDoc.docs.forEach((element) {
      _batch.update(element.reference, {'date': FieldValue.serverTimestamp()});
    });

    await _batch.commit();
  }

  batchDelete() async {
    // Batch ve Transaction Kavramları Ya Hep Ya Hiç Mantığı İle Çalışır. Ya Tüm Datalar İşlem Görür; Ya Da Hiçbir Data İşlem Görmez.
    // 1 Batch İşlemde Maksimum 500 İşlem Yapılır.
    WriteBatch _batch = _firestore.batch();
    CollectionReference _counterCollection = _firestore.collection('counter');

    var _counterDoc = await _counterCollection.get();

    _counterDoc.docs.forEach((element) {
      _batch.delete(element.reference);
    });

    await _batch.commit();
  }

  transactionProcess() async {
    // Batch ve Transaction Kavramları Ya Hep Ya Hiç Mantığı İle Çalışır. Ya Tüm Datalar İşlem Görür; Ya Da Hiçbir Data İşlem Görmez.

    // Erhan Document'ten Serhan Documebt'e 100 Lira Para Transferi Yapalım
    // 1.) Erhan Document'indeki Bakiyeyi Öğren
    // 2.) Erhan Document'indeki Bakiyeyi 100 Lira Azalt
    // 3.) Serhan Document'indeki Bakiyeyi 100 Lira Artır
    var _transferAmount = 100;
    _firestore.runTransaction((transaction) async {
      DocumentReference<Map<String, dynamic>> _erhanRefrence =
          _firestore.doc('users/rKbH4CWMbPvBfAUQTGGb');
      DocumentReference<Map<String, dynamic>> _serhanRefrence =
          _firestore.doc('users/ItZqSVWVVq4CVNR2CYSn');

      var _erhanDocumentSnapshot = await transaction.get(_erhanRefrence);
      var _erhanDocumentBalance = _erhanDocumentSnapshot['money'];

      if (_erhanDocumentBalance > _transferAmount) {
        _erhanRefrence
            .update({'money': FieldValue.increment(_transferAmount * -1)});
        _serhanRefrence
            .update({'money': FieldValue.increment(_transferAmount)});
      }
    });
  }

  queryingData() async {
    var _userCollection = _firestore.collection('users');

    var _userCollectionLimit = _firestore.collection('users').limit(
        1); // Limit İle Sorgu Sonucu Getirilecek Kayıt Sayısı Belirlenir.
    debugPrint(_userCollectionLimit.get().toString());

    var _result = await _userCollection.where('age', isEqualTo: 28).get(); // =
    // var _result = await _userCollection.where('age', isGreaterThan: 28).get(); // >
    // var _result = await _userCollection.where('age', isGreaterThanOrEqualTo: 28).get(); // >=
    // var _result = await _userCollection.where('age', isLessThan:  50).get(); //  <
    // var _result = await _userCollection.where('age', isLessThanOrEqualTo:  34).get(); //  <=
    // var _result = await _userCollection.where('age', isNotEqualTo:  28).get(); // !=
    // var _result = await _userCollection.where('age', whereIn: [55,57]  ).get(); // IN
    // var _result = await _userCollection.where('properties',arrayContains: 'red' ).get();

    for (var item in _result.docs) {
      debugPrint(item.data().toString());
    }

    var _orderedResult =
        await _userCollection.orderBy('age', descending: true).get();
    // descenging : true  ==> ORDER BY DESC
    // descenging : false ==> ORDER BY ASC

    for (var item in _orderedResult.docs) {
      debugPrint(item.data().toString());
    }

    // startAt ve endAt Metotlarını Kullanabilmek İçin Öncelikle Sıralama Yapılmalıdır.
    var _stringSearch = await _userCollection
        .orderBy('email')
        .startAt(['erhan']).endAt(['erhan' + '\uf8ff']).get();

    for (var item in _stringSearch.docs) {
      debugPrint(item.data().toString());
    }
  }

  cameraImageUpload() async {
    // firebase_storage ve image_picker Dependencyleri Eklenir.
    // Flutter Projesinin "Storage" Sekmesie Gidilir Ve Rules Menüsüne Tıklanır. Storage İşlemlerinin Yapılabilmesi İçin Buradaki read, write İzinleriin false Yerine True Yapılması ve Publish Edilmesi Gerekmektedir. Örnek Proje Storage Linki : https://console.firebase.google.com/u/1/project/flutter-firebase-lessons-fa3e4/storage?hl=TR

    final ImagePicker _picker = ImagePicker();
    XFile? _file = await _picker.pickImage(
        source: ImageSource.gallery); // Imagesource.camera
    var _profilePictureRef =
        FirebaseStorage.instance.ref('users/profilePicture');

    var _task = _profilePictureRef.putFile(File(_file!.path));

    _task.whenComplete(() async {
      var _url = await _profilePictureRef.getDownloadURL();
      debugPrint('URL: $_url');
      _firestore
          .doc('users/rKbH4CWMbPvBfAUQTGGb')
          .set({'profile_picture': _url.toString()});
    });
  }
}
