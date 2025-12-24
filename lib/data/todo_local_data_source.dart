import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TodoLocalDataSource {
  final Box _todoBox;

  TodoLocalDataSource(@Named('todoBox') this._todoBox);

  Future<List<String>> getTodos() async {
    final data = _todoBox.get('todos', defaultValue: []);
    return List<String>.from(data);
  }

  Future<void> addTodo(String task) async {
    final current = await getTodos();
    current.add(task);
    await _todoBox.put('todos', current);
  }

  Future<void> updateTodo(int index, String task) async {
    final current = await getTodos();
    current[index] = task;
    await _todoBox.put('todos', current);
  }

  Future<void> deleteTodo(int index) async {
    final current = await getTodos();
    current.removeAt(index);
    await _todoBox.put('todos', current);
  }
}
