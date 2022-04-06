import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/models/todo_model.dart';
import 'package:first_bloc/pages/todos/create_todo.dart';
import 'package:first_bloc/pages/todos/show_todos.dart';
import 'package:first_bloc/widgets/bottom_bar.dart';
import 'package:first_bloc/widgets/search_todo.dart';
import 'package:first_bloc/widgets/todo_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosList extends StatelessWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<TodoFilterBloc>().state.filter;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: filter == Filter.all
            ? const Text('All Todos')
            : filter == Filter.active
                ? const Text('Active Todos')
                : const Text('Completed Todos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const BottomBar();
                }),
              );
            },
            icon: const Icon(Icons.account_circle),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignoutRequestedEvent());
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const TodoHeader(),
            const CreateTodo(),
            const SizedBox(height: 20),
            SearchTodo(),
            const ShowTodos(),
          ],
        ),
      ),
    );
  }
}
