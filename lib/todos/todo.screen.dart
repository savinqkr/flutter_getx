import 'package:flutter/material.dart';
import 'package:flutter_getx/todos/todo.service.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:get/get.dart';

class TodoScreen extends GetView<TodoController> {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final TodoController controller =
    Get.put(TodoController(todoProvider: TodoProvider()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODOS'),
      ),
      body: SafeArea(
        child: Container(
          child: controller.obx(
            (state) => ListView.builder(
              itemCount: state!.length,
              itemBuilder: (context, index) {
                // return Text(state[index].todoTitle);
                final todo = state[index];
                return ListTile(
                  leading: Text('${todo.todoId}'),
                  title: Text(todo.todoTitle),
                  // subtitle: Text(post.postBody),
                  trailing: todo.isCompleted
                      ? const Icon(
                          MaterialSymbols.check,
                          color: Colors.teal,
                          size: 20,
                        )
                      : const Icon(
                          MaterialSymbols.close,
                          color: Colors.red,
                          size: 20,
                        ),
                );
              },
            ),
            onLoading: const Center(child: CircularProgressIndicator()),
            onError: (error) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
