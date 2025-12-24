import 'package:injectable/injectable.dart';
import 'todo_local_data_source.dart';

@lazySingleton
class TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepository(this.localDataSource);

  Future<List<String>> loadTodos() => localDataSource.getTodos();
  Future<void> addTodo(String task) => localDataSource.addTodo(task);
  Future<void> updateTodo(int index, String task) =>
      localDataSource.updateTodo(index, task);
  Future<void> deleteTodo(int index) => localDataSource.deleteTodo(index);
}
