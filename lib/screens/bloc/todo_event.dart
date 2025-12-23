abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String task;
  AddTodo(this.task);
}

class UpdateTodo extends TodoEvent {
  final int index;
  final String task;
  UpdateTodo(this.index, this.task);
}

class DeleteTodo extends TodoEvent {
  final int index;
  DeleteTodo(this.index);
}
