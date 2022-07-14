import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/model/todo_model.dart';
import 'package:flutter_todo_app/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _changeFocus(bool isFocus, TodoModel currentTodoItem) {
    if (!isFocus) {
      setState(() {
        hasFocus = false;
      });

      ref.read(todoNotifierProvider.notifier).edit(
          id: currentTodoItem.id, newDescription: _textEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodoProvider);
    return Focus(
      onFocusChange: (isFocus) => _changeFocus(isFocus, currentTodoItem),
      child: ListTile(
        onTap: () {
          setState(() {
            hasFocus = true;
            _focusNode.requestFocus();
            _textEditingController.text = currentTodoItem.description;
          });
        },
        leading: Checkbox(
          value: currentTodoItem.completed,
          onChanged: (value) {
            ref.read(todoNotifierProvider.notifier).toggle(currentTodoItem.id);
          },
        ),
        title: hasFocus
            ? TextField(
                focusNode: _focusNode,
                controller: _textEditingController,
              )
            : Text(currentTodoItem.description),
      ),
    );
  }
}
