import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
// Update ve Delete İşlemleri Daha Kolay Yapılması İçin extends HiveObject İşlemi Yapıldı
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createdTask;

  @HiveField(3)
  bool isCompleted;

  Task({
    required this.id,
    required this.name,
    required this.createdTask,
    required this.isCompleted,
  });

  factory Task.create(String name, DateTime createdTask) {
    return Task(
        id: const Uuid().v1(),
        name: name,
        createdTask: createdTask,
        isCompleted: false);
  }
}
