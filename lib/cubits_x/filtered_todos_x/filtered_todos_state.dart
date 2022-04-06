part of 'filtered_todos_cubit.dart';

/* 
Fifth cubit created. 
The state is modified first.
All the content except the {part of 'todo_list_cubit.dart';} were deleted
create variable filter and the constructor
extend Equatable
add toString
add copyWith
 */

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  const FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return const FilteredTodosState(filteredTodos: []);
  }

  @override
  List<Object?> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(todos: $filteredTodos)';

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
