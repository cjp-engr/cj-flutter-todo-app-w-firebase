import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  List<Todo> setFilteredTodos(
    Filter filter,
    List<Todo> todos,
    String searchTerm,
  ) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todo todo) => !todo.completed).toList();

        break;
      case Filter.completed:
        _filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.description.toLowerCase().contains(searchTerm))
          .toList();
    }

    return _filteredTodos;
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;
    final isThemeLightSwitch =
        context.watch<ThemeBloc>().state.isThemeLightSwitch;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              state.todos,
              context.read<TodoSearchBloc>().state.searchTerm,
            );
            context
                .read<FilteredTodosBloc>()
                .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
          },
        ),
        BlocListener<TodoFilterBloc, TodoFilterState>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              state.filter,
              context.read<TodoListBloc>().state.todos,
              context.read<TodoSearchBloc>().state.searchTerm,
            );
            context
                .read<FilteredTodosBloc>()
                .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
          },
        ),
        BlocListener<TodoSearchBloc, TodoSearchState>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              context.read<TodoListBloc>().state.todos,
              state.searchTerm,
            );
            context
                .read<FilteredTodosBloc>()
                .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
          },
        ),
      ],
      child: Expanded(
        child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(todos[index].id),
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              onDismissed: (_) {
                context
                    .read<TodoListBloc>()
                    .add(RemoveTodoEvent(todo: todos[index]));
                print(todos[index]);
              },
              confirmDismiss: (_) {
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      content: Text(
                        'Do you really want to delete?',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('NO'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('YES'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                //child: TodoItem(todo: todos[index]),
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 10,
                  ),
                  child: TodoItem(todo: todos[index]),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color:
                    isThemeLightSwitch ? Color(0xffE6D5B8) : Color(0xff395B64),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              //color: Colors.grey,
              height: 7,
            );
          },
        ),
      ),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool _error = false;
            textController.text = widget.todo.description;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text(
                    'Edit Todo',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: _error ? "Value cannot be empty" : null,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _error = textController.text.isEmpty ? true : false;
                          if (!_error) {
                            context.read<TodoListBloc>().add(EditTodoEvent(
                                  id: widget.todo.id,
                                  description: textController.text,
                                  completed: widget.todo.completed,
                                ));
                            print(widget.todo.id);
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(todo: widget.todo));
        },
      ),
      title: Text(
        widget.todo.description,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
