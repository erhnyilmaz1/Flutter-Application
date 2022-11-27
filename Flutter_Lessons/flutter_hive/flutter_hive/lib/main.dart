// ignore_for_file: avoid_function_literals_in_foreach_calls, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_hive/model/student.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter('application');
  await Hive.openBox('test');

  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(EyesColorAdapter());
  await Hive.openBox<Student>('students');

  await Hive.openLazyBox<int>('numbers');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  void _incrementCounter() async {
    var box = Hive.box('test');
    await box.clear();

    // Add & AddAll Methods
    box.add('Erhan'); // Index : 0 , Key : 0 , Value : Erhan
    box.add('Yılmaz'); // Index : 1 , Key : 1 , Value : Yılmaz
    box.add(1994); // Index : 2 , Key : 2 , Value : 1994
    box.add(true); // Index : 3 , Key : 3 , Value : true
    await box.addAll(['list1', 'list2', 15, false]);

    // Put & PutAll Methods
    await box.put("tc", '24567809634');
    await box.put("theme", 'dark');
    await box.putAll({"car": "Mercedes", "year": 2012});

    // Keys
    box.keys.forEach((element) {
      debugPrint("Keys: " + element.toString());
    });

    // Values
    box.values.forEach((element) {
      debugPrint("Values: " + element.toString());
    });

    debugPrint(box.toMap().toString());

    debugPrint(box.get("theme")); // Key İle Erişim
    debugPrint(box.getAt(0)); // Index İle Erişim

    debugPrint(box.length.toString());

    await box.delete("theme"); // Key İle Silme
    await box.deleteAt(0); // Index İle Silme
    debugPrint(box.toMap().toString());

    await box.putAt(0, "New Value"); // Güncelleme
    debugPrint(box.toMap().toString());
  }

  void _registerAdapterProcess() async {
    var erhan = Student(id: 1, name: 'Erhan', eyeColor: EyesColor.BLACK);
    var serhan = Student(id: 2, name: 'Serhan', eyeColor: EyesColor.BLUE);

    var box = Hive.box<Student>('students');
    await box.clear();
    box.add(erhan);
    box.add(serhan);

    await box.put("erhan", erhan);
    await box.put("serhan", serhan);

    debugPrint(box.toMap().toString());
  }

  void _lazyProcess() async {
    var box = Hive.lazyBox<int>('numbers');
    await box.clear();

    for (var i = 0; i < 50; i++) {
      await box.add((i + 1) * 50);
    }

    for (var i = 0; i < 50; i++) {
      debugPrint((await box.getAt(i)).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        //onPressed: _registerAdapterProcess,
        onPressed: _lazyProcess,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
