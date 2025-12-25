import 'package:flutter/material.dart';
import 'widget/todo_input.dart';
import 'widget/todo_list.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(child: TodoList()),
          TodoInput(),
        ],
      ),
    );
  }
}
