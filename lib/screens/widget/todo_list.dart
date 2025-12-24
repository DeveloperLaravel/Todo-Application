import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_state.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loaded: (todos) => todos.isEmpty
              ? const Center(child: Text('No Tasks'))
              : ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (_, index) =>
                      TodoItem(title: todos[index], index: index),
                ),
        );
      },
    );
  }
}
