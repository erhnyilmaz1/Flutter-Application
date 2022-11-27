import 'dart:math' as mathematic;
import 'package:flutter/material.dart';

class CustomScrollViewUsage extends StatelessWidget {
  const CustomScrollViewUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.red,
          // title: Text("SLIVEER APP BAR"),
          floating: true,
          pinned: true,
          snap: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("SLIVEER APP BAR"),
            centerTitle: true,
            background: Image.asset(
              "assets/images/aslan.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver:
              SliverList(delegate: SliverChildListDelegate(_constanElements())),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate(_dynamicElements, childCount: 6)),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverFixedExtentList(
            delegate: SliverChildListDelegate(_constanElements()),
            itemExtent: 100,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverFixedExtentList(
            delegate:
                SliverChildBuilderDelegate(_dynamicElements, childCount: 6),
            itemExtent: 100,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            delegate: SliverChildListDelegate(_constanElements()),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            delegate:
                SliverChildBuilderDelegate(_dynamicElements, childCount: 6),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100),
            delegate: SliverChildListDelegate(_constanElements()),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100),
            delegate:
                SliverChildBuilderDelegate(_dynamicElements, childCount: 6),
          ),
        ),
      ],
    );
  }

  List<Widget> _constanElements() {
    return [
      Container(
        height: 100,
        color: Colors.amber,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 1",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.teal,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 2",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 3",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 4",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.yellow,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 5",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 6",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.orange,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 7",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.purple,
        alignment: Alignment.center,
        child: Text(
          "STATIC ELEMENT 8",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  Widget _dynamicElements(BuildContext context, int index) {
    return Container(
      height: 100,
      color: randomColorGenerate(),
      alignment: Alignment.center,
      child: Text(
        "DYNAMIC ELEMENT ${index + 1}",
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  Color randomColorGenerate() {
    return Color.fromARGB(
        mathematic.Random().nextInt(255),
        mathematic.Random().nextInt(255),
        mathematic.Random().nextInt(255),
        mathematic.Random().nextInt(255));
  }
}
