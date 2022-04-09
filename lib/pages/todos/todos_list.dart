import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/models/todo_model.dart';
import 'package:first_bloc/pages/todos/create_todo.dart';
import 'package:first_bloc/pages/todos/show_todos.dart';
import 'package:first_bloc/pages/user/settings_page.dart';
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
                  return const SettingsPage();
                }),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you really want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('NO'),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignoutRequestedEvent());
                        },
                        child: const Text('YES'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        //Need expanded here to avoid issue render overflow
        //child: Expanded(
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
      //),
    );
  }
}
