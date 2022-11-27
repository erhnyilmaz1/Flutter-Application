// ignore_for_file: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/locale_storage.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTasks;

  CustomSearchDelegate({required this.allTasks});

  // Arama Kısmının Sağ Tarafında Yer Alan Icon'ları Temsil Eder.
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query.isEmpty ? null : query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      )
    ];
  }

// Arama Kısmının Sol Tarafında Yer Alan Icon'ları Temsil Eder.
  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
        size: 24,
      ),
    );
  }

// Arama Butonuna Bastığınızda Sonuçları Nasıl Göstermek İstediğinizi Sağlar.
  @override
  Widget buildResults(BuildContext context) {
    List<Task> filteredList = allTasks
        .where((task) => task.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filteredList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              var _selectedItem = filteredList[index];
              return Dismissible(
                key: Key(_selectedItem.id),
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text('remove_task').tr() // tr => Translate Method.
                  ],
                ),
                onDismissed: (direction) {
                  filteredList.removeAt(index);
                  locator<LocaleStorage>().deleteTask(task: _selectedItem);
                },
                child: TaskItem(
                  task: _selectedItem,
                ),
              );
            },
            itemCount: filteredList.length,
          )
        : Center(
            child:
                const Text('search_not_found').tr(), // tr => Translate Method.
          );
  }

// Girilen Her Metne Göre Sonuçları Gösterir.
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
