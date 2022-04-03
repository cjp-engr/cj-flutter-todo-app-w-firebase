import 'package:equatable/equatable.dart';
//import 'package:uuid/uuid.dart';

enum Filter {
  all,
  active,
  completed,
}

class Todo extends Equatable {
  final String id;
  final String description;
  final bool completed;

  Todo({
    required this.id,
    required this.description,
    this.completed = false,
  });

  @override
  List<Object> get props => [id, description, completed];

  @override
  String toString() =>
      'Todo(id: $id, description: $description, completed: $completed)';
}
