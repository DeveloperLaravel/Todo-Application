import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Box todoBox;

  TodoBloc(this.todoBox) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) {
      final data = todoBox.get('todos', defaultValue: []);
      emit(TodoLoaded(List<String>.from(data)));
    });

    on<AddTodo>((event, emit) {
      final current = state is TodoLoaded
          ? List<String>.from((state as TodoLoaded).todos)
          : [];
      current.add(event.task);
      todoBox.put('todos', current);
      emit(TodoLoaded(List<String>.from(current)));
    });

    on<UpdateTodo>((event, emit) {
      final current = List<String>.from((state as TodoLoaded).todos);
      current[event.index] = event.task;
      todoBox.put('todos', current);
      emit(TodoLoaded(current));
    });

    on<DeleteTodo>((event, emit) {
      final current = List<String>.from((state as TodoLoaded).todos);
      current.removeAt(event.index);
      todoBox.put('todos', current);
      emit(TodoLoaded(current));
    });
  }
}
