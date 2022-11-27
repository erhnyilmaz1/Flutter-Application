// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todoapp/providers/all_providers.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({Key? key}) : super(key: key);
  var _currentFilter = TodoListFilter.all;

  Color changeButtonColor(TodoListFilter filter) {
    return filter == _currentFilter ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoCount = ref.watch(unCompletedTodosCount);
    _currentFilter = ref.watch(todoListFilterStateProvider);
    debugPrint('Toolbar Widget Trigged.');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            todoCount == 0
                ? "All Todos Were Completed"
                : '${todoCount.toString()} Todos Could Not Completed',
            overflow:
                TextOverflow.ellipsis, // Sığmayan Yazıyı ... İle Gösterir.
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeButtonColor(TodoListFilter.all)),
              onPressed: () {
                ref.read(todoListFilterStateProvider.notifier).state =
                    TodoListFilter.all;
              },
              child: const Text('All')),
        ),
        Tooltip(
          message: 'Active Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeButtonColor(TodoListFilter.active)),
              onPressed: () {
                ref.read(todoListFilterStateProvider.notifier).state =
                    TodoListFilter.active;
              },
              child: const Text('Active')),
        ),
        Tooltip(
          message: 'Completed Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeButtonColor(TodoListFilter.completed)),
              onPressed: () {
                ref.read(todoListFilterStateProvider.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text('Completed')),
        ),
      ],
    );
  }
}
