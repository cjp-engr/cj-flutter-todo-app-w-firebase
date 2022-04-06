import 'package:first_bloc/pages/todos/todos_list.dart';
import 'package:flutter/material.dart';

class CompletedTodos extends StatelessWidget {
  const CompletedTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodosList();
  }
}
