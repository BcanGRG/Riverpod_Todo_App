import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/todo_model.dart';
import 'package:riverpod_todo_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider<TodoListFilter>(((ref) {
  return TodoListFilter.all;
}));

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "Spora Git"),
    TodoModel(id: const Uuid().v4(), description: "Ders Çalış"),
    TodoModel(id: const Uuid().v4(), description: "Alışveriş")
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>(((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.completed:
      return todoList.where((element) => element.completed).toList();
    case TodoListFilter.active:
      return todoList.where((element) => !element.completed).toList();
    default:
      return todoList;
  }
}));

final unCompletedTodoCount = Provider<int>((ref) {
  var count =
      ref.watch(todoListProvider).where((element) => !element.completed).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>(((ref) {
  throw UnimplementedError();
}));
