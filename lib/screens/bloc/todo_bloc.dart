import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/todo_repository.dart';
import '../data/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(const TodoState.initial()) {
    on<LoadTodos>((event, emit) async {
      final todos = await repository.loadTodos();
      emit(TodoState.loaded(todos));
    });

    on<AddTodo>((event, emit) async {
      await repository.addTodo(event.task);
      final todos = await repository.loadTodos();
      emit(TodoState.loaded(todos));
    });

    on<UpdateTodo>((event, emit) async {
      await repository.updateTodo(event.index, event.task);
      final todos = await repository.loadTodos();
      emit(TodoState.loaded(todos));
    });

    on<DeleteTodo>((event, emit) async {
      await repository.deleteTodo(event.index);
      final todos = await repository.loadTodos();
      emit(TodoState.loaded(todos));
    });
  }
}
