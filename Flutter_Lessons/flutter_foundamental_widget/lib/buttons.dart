import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {},
            onLongPress: () {
              debugPrint("Long Pressed");
            },
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Text Button")),
        TextButton.icon(
            onPressed: () {},
            style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all(Colors.red),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.teal;
                  }
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.orange;
                  }
                  return null;
                }),
                foregroundColor: MaterialStateProperty.all(Colors.yellow),
                overlayColor:
                    MaterialStateProperty.all(Colors.yellow.withOpacity(0.5))),
            icon: Icon(Icons.add),
            label: Text("Text Button With Icon")),
        ElevatedButton(onPressed: () {}, child: Text("Elevated Button")),
        ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                primary: Colors.yellow, onPrimary: Colors.red),
            icon: Icon(Icons.add),
            label: Text("Elevated Button With Icon ")),
        OutlinedButton(onPressed: () {}, child: Text("Outlined Button")),
        OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.purple, width: 2)),
            label: Text("OutlinedButton Button With Icon ")),
        OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.purple, width: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            label: Text("OutlinedButton Button With Icon ")),
      ],
    );
  }
}
