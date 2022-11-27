import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/*
    1.) Navigator.pop(context); ==> COMPONENT'I KALDIRIR.
*/

class ListViewUsage extends StatefulWidget {
  ListViewUsage({Key? key}) : super(key: key);

  @override
  _ListViewUsageState createState() => _ListViewUsageState();
}

class _ListViewUsageState extends State<ListViewUsage> {
  List<Student> _allStudentList = List.generate(
      500,
      (index) => Student(index + 1, "Student Name : ${index + 1}",
          "Student Surname : ${index + 1}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("ListView Usage")),
      // body: classicListViewUsage(),
      // body: listViewBuilderMethod(),
      body: listViewSeperatorMethod(),
    );
  }

  ListView listViewBuilderMethod() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var _currentStudent = _allStudentList[index];
        return Card(
          color:
              index % 2 == 0 ? Colors.orange.shade100 : Colors.purple.shade100,
          child: ListTile(
            onTap: () {
              setState(() {
                debugPrint("Element Was Clicked: $index");
              });
            },
            title: Text(_currentStudent.name),
            subtitle: Text(_currentStudent.surname),
            leading: CircleAvatar(child: Text(_currentStudent.id.toString())),
          ),
        );
      },
      itemCount: _allStudentList.length,
    );
  }

  ListView listViewSeperatorMethod() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var _currentStudent = _allStudentList[index];
          return Card(
            color: index % 2 == 0
                ? Colors.orange.shade100
                : Colors.purple.shade100,
            child: ListTile(
              onTap: () {
                setState(() {
                  //debugPrint("Element Was Clicked: $index");
                  if (index % 2 == 0) {
                    EasyLoading.instance.backgroundColor = Colors.red;
                  } else {
                    EasyLoading.instance.backgroundColor = Colors.green;
                  }
                  EasyLoading.showToast('Element Was Clicked',
                      duration: Duration(seconds: 3),
                      dismissOnTap: true,
                      toastPosition: EasyLoadingToastPosition.bottom);
                });
              },
              onLongPress: () {
                _alertDialogProcess(context, _currentStudent);
              },
              title: Text(_currentStudent.name),
              subtitle: Text(_currentStudent.surname),
              leading: CircleAvatar(child: Text(_currentStudent.id.toString())),
            ),
          );
        },
        itemCount: _allStudentList.length,
        separatorBuilder: (context, index) {
          if ((index + 1) % 4 == 0) {
            return Divider(
              thickness: 2,
              color: Colors.teal,
            );
          }
          return SizedBox();
        });
  }

  ListView classicListViewUsage() {
    return ListView(
        children: _allStudentList
            .map((Student student) => ListTile(
                  title: Text(student.name),
                  subtitle: Text(student.surname),
                  leading: CircleAvatar(child: Text(student.id.toString())),
                ))
            .toList());
  }
}

void _alertDialogProcess(BuildContext myContext, Student studentInfo) {
  showDialog(
      barrierDismissible: false,
      context: myContext,
      builder: (context) {
        return AlertDialog(
          title: Text(studentInfo.toString()),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Erhan" * 100),
                Text("Serhan" * 100),
                Text("Doğan" * 100),
              ],
            ),
          ),
          actions: [
            ButtonBar(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "CLOSE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            )
          ],
        );
      });
}

class Student {
  final int id;
  final String name;
  final String surname;

  Student(this.id, this.name, this.surname);

  @override
  String toString() {
    return "Name : $name , Surname : $surname, Id: $id";
  }
}
