import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';

class TodoInput extends StatefulWidget {
  const TodoInput({super.key});

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final controller = TextEditingController();
  int updateIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Add Task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              if (controller.text.isEmpty) return;
              if (updateIndex != -1) {
                context.read<TodoBloc>().add(
                  UpdateTodo(updateIndex, controller.text),
                );
                updateIndex = -1;
              } else {
                context.read<TodoBloc>().add(AddTodo(controller.text));
              }
              controller.clear();
            },
            child: Icon(updateIndex != -1 ? Icons.edit : Icons.add),
          ),
        ],
      ),
    );
  }
}
