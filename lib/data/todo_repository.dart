import 'package:injectable/injectable.dart';
import 'todo_local_data_source.dart';

@lazySingleton
class TodoRepository {
  final TodoLocalDataSource local;

  TodoRepository(this.local);

  Future<List<String>> loadTodos() => local.getTodos();

  Future<void> saveTodos(List<String> todos) => local.saveTodos(todos);
}
