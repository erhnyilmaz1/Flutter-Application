import 'package:flutter/material.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _elemetCount = ModalRoute.of(context)!.settings.arguments as int;
    List<Student> studentList = List.generate(
        _elemetCount,
        (index) =>
            Student(index + 1, "Erhan ${index + 1}", "Yılmaz ${index + 1}"));

    return Scaffold(
        appBar: AppBar(
          title: Text("Student List"),
        ),
        body: ListView.builder(
          itemBuilder: (builder, index) {
            return ListTile(
              onTap: () {
                var _selected = studentList[index];
                Navigator.pushNamed(context, "/studentDetail",
                    arguments: _selected);
              },
              leading: CircleAvatar(
                child: Text(studentList[index].id.toString()),
              ),
              title: Text(studentList[index].name.toString()),
              subtitle: Text(studentList[index].surname.toString()),
            );
          },
          itemCount: _elemetCount,
        ));
  }
}

class Student {
  final int id;
  final String name;
  final String surname;

  Student(this.id, this.name, this.surname);
}
