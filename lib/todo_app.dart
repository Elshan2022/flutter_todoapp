
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo_app/providers/all_providers.dart';

import 'package:flutter_todo_app/widget/title_widget.dart';
import 'package:flutter_todo_app/widget/todo_list_item_widget.dart';
import 'package:flutter_todo_app/widget/tool_bar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);

  final _hintText = "Write todos";

  final _labelText = "What are you going to do today ?";

  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: Padding(
        padding: _AppConstants.appPadding,
        child: ListView(
          children: [
            const TitleWidget(),
            _textField(ref),
            Padding(
              padding: EdgeInsets.only(top: _AppConstants._toolBarPadding),
              child: ToolBarWidget(),
            ),
            for (int i = 0; i < _allTodos.length; i++)
              Dismissible(
                background: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 0.07.sw,
                ),
                onDismissed: (_) {
                  ref.read(todoNotifierProvider.notifier).remove(_allTodos[i]);
                },
                key: ValueKey(_allTodos[i].id),
                child: ProviderScope(
                  overrides: [
                    currentTodoProvider.overrideWithValue(_allTodos[i]),
                  ],
                  child: const TodoListItemWidget(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  TextField _textField(WidgetRef ref) {
    return TextField(
      controller: _todoController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.grey.shade900,
          ),
        ),
        hintText: _hintText,
        labelText: _labelText,
      ),
      onSubmitted: (newTodo) {
        ref.read(todoNotifierProvider.notifier).addTodo(newTodo);
      },
    );
  }
}

class _AppConstants {
  static final appPadding = EdgeInsets.symmetric(horizontal: 0.03.sw);
  static final _toolBarPadding = 0.11.sw;
}
