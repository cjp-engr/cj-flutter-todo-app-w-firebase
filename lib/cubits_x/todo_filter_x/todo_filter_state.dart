part of 'todo_filter_cubit.dart';

/* 
First cubit created. 
The state is modified first.
All the content except the {part of 'todo_filter_cubit.dart';} were deleted
create variable filter and the constructor
extend Equatable
add toString
add copyWith
 */

class TodoFilterState extends Equatable {
  final Filter filter;

  const TodoFilterState({
    required this.filter,
  });

  factory TodoFilterState.initial() {
    return const TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object?> get props => [filter];

  @override
  String toString() => 'TodoFilterState(filter: $filter)';

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}
