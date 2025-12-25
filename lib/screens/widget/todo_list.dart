import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return const Center(
            child: Text('No Tasks', style: TextStyle(fontSize: 18)),
          );
        }

        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.green,
              child: ListTile(
                title: Text(
                  state.todos[index],
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// EDIT
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        context.read<TodoBloc>().add(
                          TodoEvent.startEdit(index),
                        );
                      },
                    ),

                    /// DELETE
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        context.read<TodoBloc>().add(
                          TodoEvent.deleteTodo(index),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
