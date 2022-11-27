// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todoapp/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textController;
  bool _hasFocus = false;

  @override
  void initState() {
    // initState'de Yapılacak Değişiklikler super Metodunun ALTINA Yazılır.
    super.initState();
    _textFocusNode = FocusNode();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    // dispose'da Yapılacak Değişiklikler super Metodunun ÜSTÜNE Yazılır.
    _textFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodoProvider);
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });

          ref
              .read(todoListStateNotifierProvider.notifier)
              .edit(id: currentTodoItem.id, description: _textController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            // 1 Kere Tıklandığında Text'i TextField'e Dönüştürür.
          });
          _textFocusNode.requestFocus();
          // Üzerine Tıklandığında İçerisindeki Yazının Silinmemesini Sağlar.
          _textController.text = currentTodoItem.description;
        },
        title: _hasFocus
            ? TextField(
                controller: _textController,
                focusNode: _textFocusNode,
              )
            : Text(currentTodoItem.description),
        leading: Checkbox(
            value: currentTodoItem.isCompleted,
            onChanged: (value) {
              ref
                  .read(todoListStateNotifierProvider.notifier)
                  .toggle(currentTodoItem.id);
            }),
      ),
    );
  }
}
