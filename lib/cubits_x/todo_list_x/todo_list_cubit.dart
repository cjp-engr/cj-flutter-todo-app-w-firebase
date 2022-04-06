import 'dart:async';

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

  Future<dynamic> initialLoadTodo() async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      var todos = await todoRepository.readTodo() as Map;
      for (var todo in todos.values) {
        final readTodo = Todo(
          id: todo['id'],
          description: todo['description'],
          completed: todo['completed'],
        );
        final rTodos = [...state.todos, readTodo];
        emit(state.copyWith(
          todos: rTodos,
          todoListStatus: TodoListStatus.loading,
        ));
      }
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loaded,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.error,
        error: e,
      ));
    }
  }

  Future<void> addTodo(String desc) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      String todoId = await todoRepository.addTodo(desc);
      final newTodo = Todo(
        id: todoId,
        description: desc,
      );
      final newTodos = [...state.todos, newTodo];
      emit(state.copyWith(todos: newTodos));
    } on CustomError catch (e) {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.error,
        error: e,
      ));
    }
  }

  Future<void> removeTodo(Todo todo) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      final remTodo = state.todos.where((Todo t) => t.id != todo.id).toList();
      print(todo.id);
      await todoRepository.removeTodo(todo.id);
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loaded,
        todos: remTodo,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.error,
        error: e,
      ));
    }
  }

  Future<void> editTodo(String id, String desc, bool completed) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));

      await todoRepository.editTodo(id, desc, completed);
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

      emit(state.copyWith(
        todoListStatus: TodoListStatus.loaded,
        todos: editTodo,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.error,
        error: e,
      ));
    }
  }

  Future<void> toggleTodo(Todo t) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      await todoRepository.toggleTodo(t);
      final togTodo = state.todos.map(
        (Todo todo) {
          if (t.id == todo.id) {
            return Todo(
              id: todo.id,
              description: todo.description,
              completed: !todo.completed,
            );
          }
          return todo;
        },
      ).toList();

      emit(state.copyWith(
        todoListStatus: TodoListStatus.loaded,
        todos: togTodo,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.error,
        error: e,
      ));
    }
  }
}
