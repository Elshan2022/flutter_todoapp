import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo_app/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);

  var _currentFilter = TodoListFiltered.all;
  Color _changeColor(TodoListFiltered filt) {
    return _currentFilter == filt ? Colors.red : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFiltered);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            onCompletedTodoCount == 0
                ? "Todos length"
                : "$onCompletedTodoCount  todos ",
            style: _ToolBarConstants.toolBarTextStyle(context),
          ),
        ),
        Tooltip(
          message: "All Todos",
          child: TextButton(
            style: TextButton.styleFrom(
              primary: _changeColor(TodoListFiltered.all),
            ),
            onPressed: () {
              ref.read(todoListFiltered.notifier).state = TodoListFiltered.all;
            },
            child: Text(
              "All",
              style: _ToolBarConstants.toolBarTextStyle(context),
            ),
          ),
        ),
        Tooltip(
          message: "Only uncompleted todos",
          child: TextButton(
            style: TextButton.styleFrom(
              primary: _changeColor(TodoListFiltered.active),
            ),
            onPressed: () {
              ref.read(todoListFiltered.notifier).state =
                  TodoListFiltered.active;
            },
            child: Text(
              "Active",
              style: _ToolBarConstants.toolBarTextStyle(context),
            ),
          ),
        ),
        Tooltip(
          message: "Only completed todos",
          child: TextButton(
            style: TextButton.styleFrom(
              primary: _changeColor(TodoListFiltered.completed),
            ),
            onPressed: () {
              ref.read(todoListFiltered.notifier).state =
                  TodoListFiltered.completed;
            },
            child: Text(
              "Completed",
              style: _ToolBarConstants.toolBarTextStyle(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToolBarConstants {
  static TextStyle toolBarTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 0.05.sw,
        );
  }
}
