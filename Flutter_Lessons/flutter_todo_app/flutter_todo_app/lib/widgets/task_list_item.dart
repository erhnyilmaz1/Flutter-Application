// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/locale_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late final TextEditingController _taskNameController =
      TextEditingController();
  late final LocaleStorage _localeStorage;

  @override
  void initState() {
    super.initState();
    _localeStorage = locator<LocaleStorage>();
  }

  @override
  Widget build(BuildContext context) {
    _taskNameController.text = widget.task.name;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        leading: GestureDetector(
          onTap: () {
            // StatefulWidget'da Parametre Olarak Verilen Modele Erişmek İçin widget.parameterName.property Şekline Kullanılır.
            // Örnek ==> TaskItem(task: _selectedItem,) İse TaskItem Class'da task'a erişim widget.task Şeklinde Olur.
            widget.task.isCompleted = !widget.task.isCompleted;
            _localeStorage.updateTask(task: widget.task);
            setState(() {});
          },
          child: Container(
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: widget.task.isCompleted ? Colors.green : Colors.white,
              border: Border.all(color: Colors.grey, width: 0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
        title: widget.task.isCompleted
            ? Text(
                widget.task.name,
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black,
                ),
              )
            : TextField(
                controller: _taskNameController,
                minLines: 1,
                maxLines: null, // Kelime Boyunu Bilmediğimiz İçin null Yapıldı.
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  if (value.length > 3) {
                    widget.task.name = value;
                    _localeStorage.updateTask(task: widget.task);
                  }
                },
              ),
        trailing: Text(
          DateFormat('hh:mm a').format(widget.task.createdTask),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
