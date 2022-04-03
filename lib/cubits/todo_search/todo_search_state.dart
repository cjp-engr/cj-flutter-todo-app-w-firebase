part of 'todo_search_cubit.dart';

/* 
Second cubit created. 
The state is modified first.
All the content except the {part of 'todo_search_cubit.dart';} were deleted
create variable filter and the constructor
extend Equatable
add toString
add copyWith
 */

class TodoSearchState extends Equatable {
  final String searchTerm;

  const TodoSearchState({
    required this.searchTerm,
  });

  factory TodoSearchState.initial() {
    return const TodoSearchState(searchTerm: '');
  }

  @override
  List<Object?> get props => [searchTerm];

  @override
  String toString() => 'TodoSearchState(searchTerm: $searchTerm)';

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
