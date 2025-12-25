import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoInput extends StatelessWidget {
  TodoInput({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.editingIndex != null) {
          controller.text = state.todos[state.editingIndex!];
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Task',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  if (controller.text.isEmpty) return;

                  final bloc = context.read<TodoBloc>();

                  state.editingIndex != null
                      ? bloc.add(
                          UpdateTodo(state.editingIndex!, controller.text),
                        )
                      : bloc.add(AddTodo(controller.text));

                  controller.clear();
                },
                child: Icon(
                  state.editingIndex != null ? Icons.edit : Icons.add,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
