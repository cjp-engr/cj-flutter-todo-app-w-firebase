import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_bloc/models/custom_error.dart';
import 'package:first_bloc/models/todo_model.dart';
import 'package:first_bloc/repositories/todo_repository.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  final TodoRepository todoRepository;
  TodoListCubit({
    required this.todoRepository,
  }) : super(TodoListState.initial());

  Future<void> addTodo(String desc) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      await todoRepository.addTodo(desc);
      var todo = await todoRepository.readTodo() as List;
      final newTodo = Todo(
        id: todo.last['id'],
        description: todo.last['description'],
        completed: todo.last['completed'],
      );
      final newTodos = [...state.todos, newTodo];

      emit(state.copyWith(
        todoListStatus: TodoListStatus.loaded,
        todos: newTodos,
      ));
      print(state);
    } on CustomError catch (e) {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.error,
        error: e,
      ));
    }
  }

  void editTodo(String id, String desc) {
    final editTodo = state.todos.map(
      (Todo todo) {
        if (id == todo.id) {
          return Todo(
            id: todo.id,
            description: desc,
            completed: todo.completed,
          );
        }
        return todo;
      },
    ).toList();

    emit(state.copyWith(todos: editTodo));
  }

  void toggleTodo(String id) {
    final togTodo = state.todos.map(
      (Todo todo) {
        if (id == todo.id) {
          return Todo(
            id: todo.id,
            description: todo.description,
            completed: !todo.completed,
          );
        }
        return todo;
      },
    ).toList();
    emit(state.copyWith(todos: togTodo));
  }

  void removeTodo(Todo todo) {
    final remTodo = state.todos.where((Todo t) => t.id != todo.id).toList();
    emit(state.copyWith(todos: remTodo));
  }
}
