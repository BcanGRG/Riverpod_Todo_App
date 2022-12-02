import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/models/todo_model.dart';
import 'package:riverpod_todo_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "Spora Git"),
    TodoModel(id: const Uuid().v4(), description: "Ders Çalış"),
    TodoModel(id: const Uuid().v4(), description: "Alışveriş")
  ]);
});

final unCompletedTodoCount = Provider<int>((ref) {
  var count =
      ref.watch(todoListProvider).where((element) => !element.completed).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>(((ref) {
  throw UnimplementedError();
}));
