import 'package:flutter/material.dart';

class GridViewUsage extends StatelessWidget {
  const GridViewUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return gridViewCount();
    // return gridViewExtent();
    return gridViewBuilder();
  }

  GridView gridViewCount() => GridView.count(
        crossAxisCount:
            3, // GRID'IN SATIR İÇERİSİNDE MAKSİMUM KAÇ ELEMAN ALACAĞINI BELİRLER.
        reverse: false,
        primary: false,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 40,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
        ],
      );

  GridView gridViewExtent() => GridView.extent(
        maxCrossAxisExtent:
            200, // GRID'IN SATIR İÇERİSİNDE YER ALAN MAKSIMUM GENİŞLİĞİ BELİRLER.
        reverse: false,
        primary: false,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 40,
        children: [
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.teal.shade300,
            child: Text("HELLO FLUTTER"),
          ),
        ],
      );

  GridView gridViewBuilder() => GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * ((index + 1) % 8)],
            child: Text(
              "HELLO ${index + 1}",
              textAlign: TextAlign.center,
            ),
          );
        },
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 100,
      );
}
