import 'package:flutter_riverpod_todoapp/models/todo_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    var _addTodoItem =
        TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, _addTodoItem];
    // SpreadList (İlk Parametrede Yer Alan Listeye 2. Parametredeki Değeri Ekler.)
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (id == todo.id)
          TodoModel(
            id: id,
            description: todo.description,
            isCompleted: !todo.isCompleted,
          )
        else
          todo
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (var todo in state)
        if (id == todo.id)
          TodoModel(
            id: id,
            description: description,
            isCompleted: todo.isCompleted,
          )
        else
          todo
    ];
  }

  void remove(TodoModel deletedItem) {
    state = state.where((element) => element.id != deletedItem.id).toList();
  }
}
