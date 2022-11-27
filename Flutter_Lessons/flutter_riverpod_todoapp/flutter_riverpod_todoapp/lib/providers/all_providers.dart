import 'package:flutter_riverpod_todoapp/providers/todo_list_manager.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

enum TodoListFilter { all, active, completed }

final todoListFilterStateProvider = StateProvider<TodoListFilter>((ref) {
  return TodoListFilter.all;
});

final todoListStateNotifierProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'Go To The Sport'),
    TodoModel(id: const Uuid().v4(), description: 'Do Shopping'),
    TodoModel(id: const Uuid().v4(), description: 'Study Lesson'),
    TodoModel(id: const Uuid().v4(), description: 'Watch TV'),
  ]);
});

final filteredTodos = Provider<List<TodoModel>>((ref) {
  var filter = ref.watch(todoListFilterStateProvider);
  var todoList = ref.watch(todoListStateNotifierProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.active:
      return todoList.where((element) => !element.isCompleted).toList();
    case TodoListFilter.completed:
      return todoList.where((element) => element.isCompleted).toList();
  }
});

final unCompletedTodosCount = Provider<int>((ref) {
  var allTodos = ref.watch(todoListStateNotifierProvider);
  var count = allTodos.where((element) => !element.isCompleted).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
