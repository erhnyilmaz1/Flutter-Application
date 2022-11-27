import 'package:flutter/material.dart';

/*
    1.) ListView, children PARAMETRESİ İÇERMELİDİR.
*/

class CardAndListTales extends StatefulWidget {
  CardAndListTales({Key? key}) : super(key: key);

  @override
  CardAndListTalesState createState() => CardAndListTalesState();
}

class CardAndListTalesState extends State<CardAndListTales> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: singleChildScrollViewUsage(),
      child: listViewUsage(),
    );
  }

  ListView listViewUsage() {
    return ListView(
      //reverse: true,
      children: [
        Column(
          children: [
            oddListElemen(1),
            oddListElemen(2),
            oddListElemen(3),
            oddListElemen(4),
            oddListElemen(5),
            oddListElemen(6),
            oddListElemen(7),
            oddListElemen(8),
            oddListElemen(9),
            oddListElemen(10),
          ],
        ),
        Text("Selam"),
        ElevatedButton(onPressed: () {}, child: Text("Button")),
      ],
    );
  }

  SingleChildScrollView singleChildScrollViewUsage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          oddListElemen(1),
          oddListElemen(2),
          oddListElemen(3),
          oddListElemen(4),
          oddListElemen(5),
          oddListElemen(6),
          oddListElemen(7),
          oddListElemen(8),
          oddListElemen(9),
          oddListElemen(10),
        ],
      ),
    );
  }

  Column oddListElemen(int i) {
    return Column(
      children: [
        // CARD
        Card(
          color: Colors.blue.shade200,
          shadowColor: Colors.red,
          elevation: 12,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // child: Text(
          //   "Erhan",
          //   style: TextStyle(fontSize: 48),
          // ),

          // LISTTALE
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.add)),
            title: Text("Title $i"),
            subtitle: Text("SubTitle $i"),
            trailing: Icon(Icons.real_estate_agent),
          ),
        ),
        Divider(
          color: Colors.red,
          thickness: 1,
          height: 50,
          indent: 20,
          endIndent: 60,
        )
      ],
    );
  }
}
