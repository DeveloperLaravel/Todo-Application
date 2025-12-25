import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repo;

  TodoBloc(this.repo) : super(const TodoState()) {
    on<TodoEvent>((event, emit) async {
      await event.when(
        loadTodos: () async {
          emit(state.copyWith(todos: await repo.loadTodos()));
        },

        addTodo: (task) async {
          final updated = [...state.todos, task];
          await repo.saveTodos(updated);
          emit(state.copyWith(todos: updated));
        },

        updateTodo: (index, task) async {
          final updated = [...state.todos];
          updated[index] = task;
          await repo.saveTodos(updated);
          emit(state.copyWith(todos: updated, editingIndex: null));
        },

        deleteTodo: (index) async {
          final updated = [...state.todos]..removeAt(index);
          await repo.saveTodos(updated);
          emit(state.copyWith(todos: updated));
        },

        startEdit: (index) async {
          emit(state.copyWith(editingIndex: index));
        },
      );
    });
  }
}
