part of 'active_todo_count_bloc.dart';

abstract class ActiveTodoCountEvent extends Equatable {
  const ActiveTodoCountEvent();

  @override
  List<Object> get props => [];
}

class CalculateActiveTodoCountEvent extends ActiveTodoCountEvent {
  final int activeTodoCount;
  CalculateActiveTodoCountEvent({
    required this.activeTodoCount,
  });

  @override
  String toString() =>
      'CalculateActiveTodoCountEvent(initialActiveTodoCount: $activeTodoCount)';

  @override
  List<Object> get props => [activeTodoCount];
}
