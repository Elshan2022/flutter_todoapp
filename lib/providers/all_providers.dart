import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/model/todo_model.dart';
import 'package:flutter_todo_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoListFiltered {
  all,
  active,
  completed,
}

final todoListFiltered = StateProvider<TodoListFiltered>((ref) {
  return TodoListFiltered.all;
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final todoList = ref.watch(todoNotifierProvider);
  final filtered = ref.watch(todoListFiltered);

  switch (filtered) {
    case TodoListFiltered.all:
      return todoList;
    case TodoListFiltered.completed:
      return todoList.where((element) => element.completed).toList();
    case TodoListFiltered.active:
      return todoList.where((element) => !element.completed).toList();
  }
});

final todoNotifierProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "Derse get"),
    TodoModel(id: const Uuid().v4(), description: "Idman ele"),
    TodoModel(id: const Uuid().v4(), description: "Learn Flutter")
  ]);
});

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoNotifierProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
