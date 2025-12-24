import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_event.freezed.dart';

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.loadTodos() = LoadTodos;
  const factory TodoEvent.addTodo(String task) = AddTodo;
  const factory TodoEvent.updateTodo(int index, String task) = UpdateTodo;
  const factory TodoEvent.deleteTodo(int index) = DeleteTodo;
}
