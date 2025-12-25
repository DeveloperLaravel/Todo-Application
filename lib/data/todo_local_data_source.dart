import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TodoLocalDataSource {
  final Box box;

  TodoLocalDataSource(@Named('todoBox') this.box);

  Future<List<String>> getTodos() async =>
      List<String>.from(box.get('todos', defaultValue: []));

  Future<void> saveTodos(List<String> todos) async => box.put('todos', todos);
}
