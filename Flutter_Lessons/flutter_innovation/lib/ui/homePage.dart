// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_innovation/model/data.dart';

class HomePage extends StatefulWidget {
  const HomePage(PageStorageKey<String> homePageKey, {Key? key})
      : super(key: homePageKey);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> allData = [];
  @override
  void initState() {
    allData = [
      Data('Biz Kimiz', false, 'İçerik 1'),
      Data('Biz Neredeyiz', false, 'İçerik 2'),
      Data('Misyonumuz', false, 'İçerik 3'),
      Data('Vizyonumuz', false, 'İçerik 4'),
      Data('İletişim', false, 'İçerik 5'),
      Data('Profil', false, 'İçerik 6'),
      Data('Haberler', false, 'İçerik 7'),
      Data('Veriler', false, 'İçerik 8'),
      Data('Kaynaklar', false, 'İçerik 9'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ExpansionTile(
          key: PageStorageKey("$index"),
          title: Text(allData[index].header),
          initiallyExpanded: allData[index].expanded,
          children: <Widget>[
            Container(
              height: 100,
              //width: double?.infinity,
              color:
                  index % 2 == 0 ? Colors.red.shade200 : Colors.orange.shade200,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(allData[index].content),
              ),
            ),
          ],
        );
      },
      itemCount: allData.length,
    );
  }
}
