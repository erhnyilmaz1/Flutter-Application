import 'package:flutter/material.dart';

class OrangePage extends StatelessWidget {
  OrangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orange Page'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Orange Page',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.purple.shade600),
                child: Text("En Başa Geri Dön")),
            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, (route) => route.settings.name == "/purplePage");
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.orange.shade600),
                child: Text("Mor Sayfaya Geri Dön")),
            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                      context, (route) => route.settings.name == "/");
                },
                style: ElevatedButton.styleFrom(primary: Colors.teal.shade600),
                child: Text("En Başa Dön")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/yellowPage", (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
                child: Text("En Başa Dön ve Sonra Sarı Sayfaya Git")),
          ],
        ),
      ),
    );
  }
}
