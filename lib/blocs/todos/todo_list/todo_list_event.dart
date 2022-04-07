part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class InitialLoadTodoEvent extends TodoListEvent {}

class AddTodoEvent extends TodoListEvent {
  final String description;
  AddTodoEvent({
    required this.description,
  });

  @override
  String toString() => 'AddTodoEvent(description: $description)';

  @override
  List<Object> get props => [description];
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo todo;
  RemoveTodoEvent({
    required this.todo,
  });

  @override
  String toString() => 'RemoveTodoEvent(todo: $todo)';

  @override
  List<Object> get props => [todo];
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String description;
  final bool completed;
  EditTodoEvent({
    required this.id,
    required this.description,
    required this.completed,
  });

  @override
  String toString() =>
      'EditTodoEvent(id: $id, description: $description, completed: $completed)';

  @override
  List<Object> get props => [
        id,
        description,
        completed,
      ];
}

class ToggleTodoEvent extends TodoListEvent {
  final Todo todo;
  ToggleTodoEvent({
    required this.todo,
  });

  @override
  String toString() => 'ToggleTodoEvent(todo: $todo)';

  @override
  List<Object> get props => [todo];
}
