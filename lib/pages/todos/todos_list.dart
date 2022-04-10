import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/models/models.dart';
import 'package:first_bloc/pages/todos/create_todo.dart';
import 'package:first_bloc/pages/todos/show_todos.dart';
import 'package:first_bloc/pages/user/settings_page.dart';
import 'package:first_bloc/widgets/logout_show_dialog.dart';
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
        title: Text(
          filter == Filter.all
              ? 'All Todos'
              : filter == Filter.active
                  ? 'Active Todos'
                  : 'Completed Todos',
          style: Theme.of(context).textTheme.headline5,
        ),
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
              logoutShowDialog(context);
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
