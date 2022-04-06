part of 'active_todo_count_cubit.dart';

/* 
Fourth cubit created. 
The state is modified first.
All the content except the {part of 'todo_list_cubit.dart';} were deleted
create variable filter and the constructor
extend Equatable
add toString
add copyWith
 */

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState({required this.activeTodoCount});

  @override
  List<Object?> get props => [activeTodoCount];

  factory ActiveTodoCountState.initial() {
    return const ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
