import 'dart:ui';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String _imgUrl =
      "//upload.wikimedia.org/wikipedia/commons/thumb/7/73/Lion_waiting_in_Namibia.jpg/220px-Lion_waiting_in_Namibia.jpg";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.teal, accentColor: Colors.purple),
        home: Scaffold(
          // backgroundColor: Colors.yellow,
          appBar: AppBar(title: Text("Başlık")),
          body: homework1(),
          // body: expandedFlexibleMethod(),
          // body: rowColumnProcess(),
          // body: containerLesson(),
          // body: factorProcess(),
          // body: containerProcess(),
          // body: helloWorld(),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.account_circle_rounded,
              color: Colors.green,
            ),
            onPressed: () {
              debugPrint("Tıklandı");
            },
          ),
        ));
  }

  Container homework1() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [dartCreateRow(), Expanded(child: lessonCreateCloumn())],
      ),
    );
  }

  Row dartCreateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        dartLessonsContainer("D", Colors.orange.shade100),
        dartLessonsContainer("A", Colors.orange.shade300),
        dartLessonsContainer("R", Colors.orange.shade500),
        dartLessonsContainer("T", Colors.orange.shade700),
      ],
    );
  }

  Column lessonCreateCloumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: dartLessonsContainer("E", Colors.orange.shade200, margin: 15),
        ),
        Expanded(
          child: dartLessonsContainer("R", Colors.orange.shade300, margin: 15),
        ),
        Expanded(
          child: dartLessonsContainer("S", Colors.orange.shade400, margin: 15),
        ),
        Expanded(
          child: dartLessonsContainer("L", Colors.orange.shade500, margin: 15),
        ),
        Expanded(
          child: dartLessonsContainer("E", Colors.orange.shade600, margin: 15),
        ),
        Expanded(
          child: dartLessonsContainer("R", Colors.orange.shade700, margin: 15),
        ),
        Expanded(
          child: dartLessonsContainer("İ", Colors.orange.shade800, margin: 15),
        ),
      ],
    );
  }

  Container dartLessonsContainer(String letter, Color color,
      {double margin = 0}) {
    return Container(
      width: 75,
      height: 75,
      color: color,
      margin: EdgeInsets.only(top: margin),
      alignment: Alignment.center,
      child: Text(letter, style: TextStyle(fontSize: 48)),
    );
  }

  Container expandedFlexibleMethod() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // children: problemContainer,
        // children: expandedContainer,
        children: flexibleContainer,
      ),
    );
  }

  List<Widget> get problemContainer {
    return [
      Container(
        width: 75,
        height: 75,
        color: Colors.yellow,
      ),
      Container(
        width: 75,
        height: 75,
        color: Colors.red,
      ),
      Container(
        width: 75,
        height: 75,
        color: Colors.blue,
      ),
      Container(
        width: 75,
        height: 75,
        color: Colors.orange,
      ),
      Container(
        width: 75,
        height: 75,
        color: Colors.yellow,
      ),
      Container(
        width: 75,
        height: 75,
        color: Colors.red,
      ),
      Container(
        width: 75,
        height: 75,
        color: Colors.blue,
      ),
      Container(
        width: 75,
        height: 75,
        color: Colors.orange,
      ),
    ];
  }

  Container rowColumnProcess() {
    return Container(
      color: Colors.red.shade300,
      //height: 400,
      //child: Row(
      child: Column(
        mainAxisSize: MainAxisSize
            .max, // ALAN BÜYÜTME : Row İse x Ekseninde , Column İse y Ekseninde
        mainAxisAlignment: MainAxisAlignment
            .spaceAround, //  HİZALAMA: Row İse x Ekseninde , Column İse y Ekseninde
        crossAxisAlignment: CrossAxisAlignment
            .start, // HİZALAMA: Row İse y Ekseninde , Column İse x Ekseninde
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("E"),
              Text("R"),
              Text("H"),
              Text("A"),
              Text("N"),
            ],
          ),
          Icon(
            Icons.add_circle,
            size: 64,
            color: Colors.green,
          ),
          Icon(
            Icons.add_circle,
            size: 64,
            color: Colors.red,
          ),
          Icon(
            Icons.add_circle,
            size: 64,
            color: Colors.blue,
          ),
          Icon(
            Icons.add_circle,
            size: 64,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  List<Widget> get expandedContainer {
    return [
      Expanded(
          // MÜMKÜN OLAN BÜTÜN ALANA YAYILMAYA ÇALIŞIYOR. (MAX WIDTH VEYA MAX HEIGHT'TEN BÜYÜK OLSA DA GENİŞLEYEBİLİR.)
          flex: 2, // ALANI ESNETME
          child: Container(
            width: 75,
            height: 75,
            color: Colors.yellow,
          )),
      Expanded(
          flex: 3, // ALANI ESNETME
          child: Container(
            width: 75,
            height: 75,
            color: Colors.red,
          )),
      Expanded(
          flex: 1, // ALANI ESNETME
          child: Container(
            width: 75,
            height: 75,
            color: Colors.blue,
          )),
      Expanded(
          child: Container(
        width: 75,
        height: 75,
        color: Colors.orange,
      )),
    ];
  }

  List<Widget> get flexibleContainer {
    return [
      Flexible(
          // EN FAZLA VERİLEN GENİŞLİK(MAX WIDTH OR MAX HEIGHT) KADAR BÜYÜR.
          flex: 1, // ALANI ESNETME
          child: Container(
            width: 75,
            height: 75,
            color: Colors.yellow,
          )),
      Flexible(
          flex: 1, // ALANI ESNETME
          child: Container(
            width: 75,
            height: 75,
            color: Colors.red,
          )),
      Flexible(
          flex: 1, // ALANI ESNETME
          child: Container(
            width: 75,
            height: 75,
            color: Colors.red,
          )),
      Flexible(
          flex: 1, // ALANI ESNETME
          child: Container(
            width: 75,
            height: 75,
            color: Colors.red,
          )),
    ];
  }

  Text helloWorld() {
    return Text(
      "Merhaba Dünya",
      style: TextStyle(
          color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Container containerProcess() {
    return Container(
      //alignment: Alignment.topCenter,
      color: Colors.purple,
      width: 200,
      height: 200,
      child: Text(
        "erhan" * 2,
        textAlign: TextAlign.center,
      ),
      //width: 200,
      //height: 300,
      margin: EdgeInsets.fromLTRB(10, 20, 2, 60),
      padding: EdgeInsets.all(10),
      // constraints: BoxConstraints(
      //     minWidth: 100, minHeight: 100, maxWidth: 200, maxHeight: 200),
    );
  }

  Center factorProcess() {
    return Center(
      widthFactor: 2, // childwidth  * value (burada 2)
      heightFactor: 2, // childheight * value (burada 2)
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
        //alignment: alignment.center,
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 50,
          height: 50,
          margin: EdgeInsets.all(40),
          child: Text("erhan"),
        ),
      ),
    );
  }

  Center containerLesson() {
    return Center(
      child: Container(
        // child: FlutterLogo(
        //   textColor: Colors.purple,
        //   style: FlutterLogoStyle.horizontal,
        //   size: 128,
        // ),
        child: Text(
          "Erhan",
          style: TextStyle(fontSize: 128),
        ),
        decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.rectangle,
            border: Border.all(width: 1, color: Colors.purple),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(_imgUrl),
                fit: BoxFit.scaleDown,
                repeat: ImageRepeat.repeat),
            boxShadow: [
              // MUST LIST
              BoxShadow(
                  color: Colors.green, offset: Offset(0, 20), blurRadius: 20),
              BoxShadow(
                  color: Colors.yellow, offset: Offset(0, -20), blurRadius: 10)
            ]),
      ),
    );
  }
}
