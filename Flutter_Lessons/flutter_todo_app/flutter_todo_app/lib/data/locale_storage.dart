import 'package:flutter_todo_app/models/task_model.dart';
import 'package:hive/hive.dart';

abstract class LocaleStorage {
  Future<void> addTask({required Task task});
  Future<Task?> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}

class HiveLocaleStorage extends LocaleStorage {
  late Box<Task> _taskBox;

  HiveLocaleStorage() {
    _taskBox = Hive.box<Task>('tasks');
  }
  @override
  Future<void> addTask({required Task task}) async {
    await _taskBox.put(task.id, task);
  }
  @override
  Future<bool> deleteTask({required Task task}) async {
    task.delete();
    return true;
  }
  @override
  Future<List<Task>> getAllTask() async {
    List<Task> _allTask = <Task>[];
    _allTask = _taskBox.values.toList();

    if (_allTask.isNotEmpty) {
      _allTask.sort((Task a, Task b) => b.createdTask.compareTo(a.createdTask));
    }
    return _allTask;
  }
  @override
  Future<Task?> getTask({required String id}) async {
    if (_taskBox.containsKey(id)) {
      return _taskBox.get(id);
    } else {
      return null;
    }
  }

  @override
  Future<Task> updateTask({required Task task}) async {
    await task.save();
    return task;
  }
}
