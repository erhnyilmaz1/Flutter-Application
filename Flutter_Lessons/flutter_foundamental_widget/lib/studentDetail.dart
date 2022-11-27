import 'package:flutter/material.dart';
import 'package:flutter_foundamental_widget/studentList.dart';

class StudentDetail extends StatelessWidget {
  final Student student;
  const StudentDetail({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: Column(
        children: [
          Text(student.id.toString()),
          Text(student.name),
          Text(student.surname),
        ],
      ),
    );
  }
}
