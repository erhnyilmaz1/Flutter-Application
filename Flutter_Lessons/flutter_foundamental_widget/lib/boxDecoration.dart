import 'package:flutter/material.dart';

class BoxDecorationUsed extends StatelessWidget {
  const BoxDecorationUsed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                width: 10,
              ),
              //borderRadius: new BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                new BoxShadow(
                  color: Colors.red,
                  offset: new Offset(20.0, 10.0),
                  blurRadius: 20.0,
                ),
              ],
              color: Colors.blue[100 * ((index + 1) % 8)],
              gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.red],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              shape: BoxShape.circle,
              image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
                image: AssetImage("assets/images/aslan.jpg"),
              )),
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "HELLO FLUTTER ${index + 1}",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      },
      itemCount: 100,
    );
  }
}
