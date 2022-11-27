// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todoapp/providers/all_providers.dart';
import 'package:flutter_riverpod_todoapp/widgets/future_provider_example.dart';
import 'package:flutter_riverpod_todoapp/widgets/title_widget.dart';
import 'package:flutter_riverpod_todoapp/widgets/todo_listitem_widget.dart';
import 'package:flutter_riverpod_todoapp/widgets/toolbar_widget.dart';

class ToDoApp extends ConsumerWidget {
  ToDoApp({Key? key}) : super(key: key);
  final newToDoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodos);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ListView(
          children: <Widget>[
            const TitleWidget(),
            TextField(
              controller: newToDoController,
              decoration: const InputDecoration(
                labelText: 'What will you do today?',
              ),
              onSubmitted: (newTodoDescription) {
                ref
                    .read(todoListStateNotifierProvider.notifier)
                    .addTodo(newTodoDescription);
                newToDoController.text = '';
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ToolbarWidget(),
            allTodos.isEmpty
                ? const Text('There Is No Todos')
                : const SizedBox(),
            for (var i = 0; i < allTodos.length; i++)
              Dismissible(
                  key: ValueKey(allTodos[i].id),
                  onDismissed: (deletedItem) {
                    ref
                        .read(todoListStateNotifierProvider.notifier)
                        .remove(allTodos[i]);
                  },
                  child: ProviderScope(
                    overrides: [
                      currentTodoProvider.overrideWithValue(allTodos[i]),
                    ],
                    child: const TodoListItemWidget(),
                  )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FutureProviderExample() ));
                }, child: const Text('Future Provider Exapmle'))
          ],
        ),
      ),
    );
  }
}
