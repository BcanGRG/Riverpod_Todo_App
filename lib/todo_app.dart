import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/providers/all_providers.dart';
import 'package:riverpod_todo_app/widgets/future_provider_page.dart';
import 'package:riverpod_todo_app/widgets/title_widget.dart';
import 'package:riverpod_todo_app/widgets/todo_list_item_widget.dart';
import 'package:riverpod_todo_app/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});

  final newTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTextController,
            decoration:
                const InputDecoration(labelText: "Neler yapacaksın bugün ?"),
            onSubmitted: ((value) {
              ref.read(todoListProvider.notifier).addTodo(value);
              newTextController.text = "";
            }),
          ),
          const SizedBox(height: 30),
          ToolBarWidget(),
          allTodos.isEmpty
              ? const Center(child: Text("Herhangi bir görev yok"))
              : const SizedBox(),
          for (var todo in allTodos.reversed)
            Dismissible(
                key: ValueKey(todo.id),
                onDismissed: ((_) {
                  ref.read(todoListProvider.notifier).removeTodo(todo);
                }),
                child: ProviderScope(
                  overrides: [
                    currentTodoProvider.overrideWithValue(todo),
                  ],
                  child: const TodoListItemWidget(),
                )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const FutureProviderPage()));
            },
            child: const Text("Future Provider Example"),
          )
        ],
      ),
    );
  }
}
