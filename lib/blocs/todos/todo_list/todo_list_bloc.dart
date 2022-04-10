import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_bloc/models/models.dart';

import 'package:first_bloc/repositories/todo_repository.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final TodoRepository todoRepository;
  TodoListBloc({
    required this.todoRepository,
  }) : super(TodoListState.initial()) {
    on<InitialLoadTodoEvent>(_initialLoadTodo);

    on<AddTodoEvent>(_addTodo);

    on<RemoveTodoEvent>(_removeTodo);

    on<EditTodoEvent>(_editTodo);

    on<ToggleTodoEvent>(_toggleTodo);
  }

  Future<void> _initialLoadTodo(
    InitialLoadTodoEvent event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      List<Todo> clearExistingTodos = [];
      emit(state.copyWith(
        todos: clearExistingTodos,
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

  Future<void> _addTodo(
    AddTodoEvent event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      String todoId = await todoRepository.addTodo(event.description);
      final newTodo = Todo(
        id: todoId,
        description: event.description,
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

  Future<void> _removeTodo(
    RemoveTodoEvent event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      final remTodo =
          state.todos.where((Todo t) => t.id != event.todo.id).toList();

      await todoRepository.removeTodo(event.todo.id);
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

  Future<void> _editTodo(
    EditTodoEvent event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));

      await todoRepository.editTodo(
          event.id, event.description, event.completed);
      final editTodo = state.todos.map(
        (Todo todo) {
          if (event.id == todo.id) {
            return Todo(
              id: todo.id,
              description: event.description,
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

  Future<void> _toggleTodo(
    ToggleTodoEvent event,
    Emitter<TodoListState> emit,
  ) async {
    try {
      emit(state.copyWith(
        todoListStatus: TodoListStatus.loading,
      ));
      await todoRepository.toggleTodo(event.todo);
      final togTodo = state.todos.map(
        (Todo todo) {
          if (event.todo.id == todo.id) {
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
