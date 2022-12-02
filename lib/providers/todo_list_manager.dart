import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager(List<TodoModel> initialList) : super(initialList);

  void addTodo(String description) {
    var willBeAddedTodo =
        TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, willBeAddedTodo];
  }

  void toogleTodo(String id) {
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

  void editTodo({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: newDescription,
              completed: todo.completed)
        else
          todo
    ];
  }

  void removeTodo(TodoModel willBeRemovedTodo) {
    state =
        state.where((element) => element.id != willBeRemovedTodo.id).toList();
  }

  int onCompletedTodoCount() {
    return state.where((element) => !element.completed).length;
  }
}
