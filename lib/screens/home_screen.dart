import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';
import 'bloc/todo_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  int updateIndex = -1;

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(LoadTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          /// LIST
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoaded) {
                  if (state.todos.isEmpty) {
                    return const Center(child: Text('No Tasks'));
                  }

                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.green,
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            state.todos[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// EDIT
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _controller.text = state.todos[index];
                                  updateIndex = index;
                                },
                              ),

                              /// DELETE
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context.read<TodoBloc>().add(
                                    DeleteTodo(index),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),

          /// INPUT
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Create Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    if (_controller.text.isEmpty) return;

                    if (updateIndex != -1) {
                      context.read<TodoBloc>().add(
                        UpdateTodo(updateIndex, _controller.text),
                      );
                      updateIndex = -1;
                    } else {
                      context.read<TodoBloc>().add(AddTodo(_controller.text));
                    }

                    _controller.clear();
                  },
                  child: Icon(updateIndex != -1 ? Icons.edit : Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
