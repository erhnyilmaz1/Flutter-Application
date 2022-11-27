import 'package:flutter/material.dart';

/*
    1.) shrinkWrap: true ==> ListView, Sayfada ListView'in height DEĞERİ YER KAPLAR.
*/

class ListViewLayout extends StatefulWidget {
  ListViewLayout({Key? key}) : super(key: key);

  @override
  _ListViewLayoutState createState() => _ListViewLayoutState();
}

class _ListViewLayoutState extends State<ListViewLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("ListView Layout"),),
      body: Container(
        // child: listViewInColumn(),
        height: 200,
        child: listViewInRow(),
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.red),
        ),
      ),
    );
  }

  Column listViewInColumn() {
    return Column(
      children: [
        Text("Started"),
        Expanded(
          child: ListView(
            //shrinkWrap: true,
            children: [
              Container(
                height: 200,
                color: Colors.orange.shade200,
              ),
              Container(
                height: 200,
                color: Colors.orange.shade400,
              ),
            ],
          ),
        ),
        Text("Ended"),
      ],
    );
  }
}

Row listViewInRow() {
  return Row(
    children: [
      Text("Started"),
      Expanded(
        child: ListView(
          //shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          //reverse: true,
          children: [
            Container(
              width: 200,
              color: Colors.orange.shade200,
            ),
            Container(
              width: 200,
              color: Colors.orange.shade400,
            ),
            Container(
              width: 200,
              color: Colors.orange.shade200,
            ),
            Container(
              width: 200,
              color: Colors.orange.shade400,
            ),
          ],
        ),
      ),
      Text("Ended"),
    ],
  );
}
