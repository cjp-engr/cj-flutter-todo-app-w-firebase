part of 'todo_list_bloc.dart';

enum TodoListStatus {
  initial,
  loading,
  loaded,
  error,
}

class TodoListState extends Equatable {
  final TodoListStatus todoListStatus;
  final List<Todo> todos;
  final CustomError error;

  const TodoListState({
    required this.todoListStatus,
    required this.todos,
    required this.error,
  });

  factory TodoListState.initial() {
    return TodoListState(
      todoListStatus: TodoListStatus.initial,
      todos: [],
      error: CustomError(),
    );
  }

  @override
  List<Object?> get props => [todoListStatus, todos, error];

  @override
  String toString() =>
      'TodoListState(todoListStatus: $todoListStatus, todos: $todos, error: $error)';

  TodoListState copyWith({
    TodoListStatus? todoListStatus,
    List<Todo>? todos,
    CustomError? error,
  }) {
    return TodoListState(
      todoListStatus: todoListStatus ?? this.todoListStatus,
      todos: todos ?? this.todos,
      error: error ?? this.error,
    );
  }
}
