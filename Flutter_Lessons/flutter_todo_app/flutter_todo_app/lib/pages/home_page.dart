// ignore_for_file: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_todo_app/data/locale_storage.dart';
import 'package:flutter_todo_app/helper/translation_helper.dart';
import 'package:flutter_todo_app/main.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/widgets/custom_search_delegate.dart';
import 'package:flutter_todo_app/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _allTasks;
  late LocaleStorage _localeStorage;

  @override
  void initState() {
    super.initState();
    _localeStorage = locator<LocaleStorage>();
    _allTasks = <Task>[];
    _getAllTaskFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet();
          },
          child: const Text(
            'title',
            style: TextStyle(
              color: Colors.black,
            ),
          ).tr(), // tr => Translate Method.
        ),
        centerTitle: false, // IOS İçin
        actions: [
          IconButton(
            onPressed: () {
              _showSearchPage();
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAddTaskBottomSheet();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var _selectedItem = _allTasks[index];
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
                    _allTasks.removeAt(index);
                    _localeStorage.deleteTask(task: _selectedItem);
                    setState(() {});
                  },
                  child: TaskItem(
                    task: _selectedItem,
                  ),
                );
              },
              itemCount: _allTasks.length,
            )
          : Center(
              child:
                  const Text('empty_task_list').tr(), // tr => Translate Method.
            ),
    );
  }

  void _showSearchPage() async {
    await showSearch(
        context: context, delegate: CustomSearchDelegate(allTasks: _allTasks));
    setState(() {});
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'add_task'.tr(), // tr => Translate Method.
              ),
              onSubmitted: (value) {
                Navigator.of(context).pop();
                if (value.length > 3) {
                  DatePicker.showTimePicker(
                    context,
                    showSecondsColumn: false,
                    locale: TranslationHelper.getLocaleType(context),                    
                    onConfirm: (time) async {
                      var newAdd = Task.create(value, time);
                      //_allTasks.add(newAdd);
                      _allTasks.insert(0, newAdd);
                      await _localeStorage.addTask(task: newAdd);
                      setState(() {});
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _getAllTaskFromDB() async {
    _allTasks = await _localeStorage.getAllTask();
    setState(() {});
  }
}
