import 'package:flutter/material.dart';

/*
    1.) icon ve child AYNI ANDA KULLANILMAZ.
*/

class PopupMenuButtons extends StatefulWidget {
  PopupMenuButtons({Key? key}) : super(key: key);

  @override
  _PopupMenuButtonsState createState() => _PopupMenuButtonsState();
}

class _PopupMenuButtonsState extends State<PopupMenuButtons> {
  String _chooseCity = "İstanbul";
  List<String> _colorList = ["Yellow", "Red", "Blue", "Green"];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopupMenuButton<String>(
        /* itemBuilder: (BuildContext context) {
           return <PopupMenuEntry<String>>[
             PopupMenuItem(
               child: Text("İstanbul City"),
               value: "İstanbul",
             ),
             PopupMenuItem(
               child: Text("Ankara City"),
               value: "Ankara",
             ),
             PopupMenuItem(
               child: Text("İzmir City"),
               value: "İzmir",
             ),
             PopupMenuItem(
               child: Text("Bursa City"),
               value: "Bursa",
             ),
             PopupMenuItem(
               child: Text("Adıyaman City"),
               value: "Adıyaman",
             ),
             PopupMenuItem(
               child: Text("Van City"),
               value: "Van",
             ),
           ];
        }, */
 
        itemBuilder: (BuildContext context) {
          return _colorList
              .map((String currentValue) =>
                  PopupMenuItem(child: Text(currentValue), value: currentValue))
              .toList();
        },
        //icon: Icon(Icons.add),
        child: Text(_chooseCity),
        onSelected: (String newValue) {
          setState(() {
            print("Choose City: $newValue");
            _chooseCity = newValue;
          });
        },
      ),
    );
  }
}
