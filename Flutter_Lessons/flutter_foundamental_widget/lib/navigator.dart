import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foundamental_widget/navigator/greenPage.dart';
import 'package:flutter_foundamental_widget/navigator/redPage.dart';

class NavigatorUsage extends StatelessWidget {
  const NavigatorUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                int? _incomingNumber = await Navigator.push<int>(context,
                    CupertinoPageRoute(builder: (redContext) => RedPage()));
                print("IOS For Incoming Number: $_incomingNumber");
              },
              style: ElevatedButton.styleFrom(primary: Colors.red.shade300),
              child: Text(
                "Navigate Red Page For IOS",
              )),
          ElevatedButton(
              onPressed: () {
                //Navigator.push(context, route); // SAYFALAR ARASI GEÇİŞİ SAĞLAR.
                Navigator.of(context)
                    .push<int?>(
                        MaterialPageRoute(builder: (redContext) => RedPage()))
                    .then((int? value) => debugPrint(
                        "Android For Incoming Number: $value")); // SAYFALAR ARASI GEÇİŞİ SAĞLAR.
              },
              style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
              child: Text(
                "Navigate Red Page For Android",
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
              child: Text(
                "MaybePop Button",
              )),
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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (greenContext) => GreenPage()));
              },
              style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
              child: Text(
                "PushReplacament Button",
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/redPage");
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue.shade600),
              child: Text(
                "Named Red Button",
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/orangePage2");
              },
              style: ElevatedButton.styleFrom(primary: Colors.green.shade600),
              child: Text(
                "onUnKnownRoute Button",
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/studentList", arguments: 80);
              },
              style: ElevatedButton.styleFrom(primary: Colors.grey.shade400),
              child: Text("Create List")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/orangePage");
              },
              style: ElevatedButton.styleFrom(primary: Colors.orange.shade700),
              child: Text("Named Orange Button")),
        ],
      ),
    );
  }
}
