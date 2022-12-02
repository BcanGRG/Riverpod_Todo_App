import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo_app/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int onCompletedTodoCount = ref
        .watch(todoListProvider)
        .where((element) => !element.completed)
        .length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          onCompletedTodoCount == 0
              ? "Tüm görevler tamamlandı"
              : "${ref.watch(unCompletedTodoCount)} görev tamamlanmadı",
          overflow: TextOverflow.ellipsis,
        )),
        Tooltip(
          message: "All Todos",
          child: TextButton(onPressed: () {}, child: Text("All")),
        ),
        Tooltip(
          message: "Only Uncompleted Todos",
          child: TextButton(onPressed: () {}, child: Text("Active")),
        ),
        Tooltip(
          message: "Only Completed Todos",
          child: TextButton(onPressed: () {}, child: Text("Complete")),
        )
      ],
    );
  }
}
