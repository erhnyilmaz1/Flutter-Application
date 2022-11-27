import 'dart:math';

import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
  RedPage({Key? key}) : super(key: key);
  int? _randomNumber = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("onWillPop Runned");

        if (_randomNumber == 0) {
          _randomNumber = Random().nextInt(100);
          Navigator.pop(context, _randomNumber);
        }

        return Future.value(false);
        // false: SAYFA YÖNLENDİRME BUTONLARI (Back , Next) ÇALIŞMAZ.
        // true : SAYFA YÖNLENDİRME BUTONLARI (Back , Next) ÇALIŞIR.
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Red Page'),
          backgroundColor: Colors.red,
          // automaticallyImplyLeading: false, // SAYFA YÖNLENDİRME BUTONLARI (Back , Next) false İLE KALDIRILIR.
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Red Page',
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                  onPressed: () {
                    _randomNumber = Random().nextInt(100);
                    print("Random Number: $_randomNumber");
                    Navigator.of(context).pop(_randomNumber);
                  },
                  child: Text("BACK")),
              ElevatedButton(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      print("YES");
                    } else {
                      print("NO");
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
                  child: Text(
                    "CanPop Button",
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/orangePage");
                  },
                  style:
                      ElevatedButton.styleFrom(primary: Colors.orange.shade600),
                  child: Text(
                    "Named Orange Button",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
