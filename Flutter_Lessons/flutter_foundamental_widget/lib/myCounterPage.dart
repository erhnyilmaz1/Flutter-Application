import 'package:flutter/material.dart';

class MyCounterPage extends StatefulWidget {
  MyCounterPage({Key? key}) : super(key: key);

  @override
  MyCounterPageState createState() => MyCounterPageState();
}

class MyCounterPageState extends State<MyCounterPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint("MyHomePage Class Run");
    return Scaffold(
      appBar: AppBar(title: Text("My Counter AppBar")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Click Button Count", style: TextStyle(fontSize: 24)),
            ),
            Center(
              child: Text(_count.toString(),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Button Click And New Count Value : $_count");
          increaseCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void increaseCount() {
    setState(() {
      _count++;
    });
  }
}
