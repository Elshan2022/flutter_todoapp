import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodo]) : super(initialTodo ?? []);

  void addTodo(String description) {
    var addedTodo = TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, addedTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: todo.description,
            completed: !todo.completed,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: id,
            completed: todo.completed,
            description: newDescription,
          )
        else
          todo,
    ];
  }

  void remove(TodoModel deleteTodo) {
    state = state.where((element) => element.id != deleteTodo.id).toList();
  }

  int unCompletedTodoCount() {
    return state.where((element) => !element.completed).length;
  }
}
