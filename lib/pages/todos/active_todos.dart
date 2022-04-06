import 'package:first_bloc/pages/todos/todos_list.dart';
import 'package:flutter/material.dart';

class ActiveTodos extends StatelessWidget {
  const ActiveTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TodosList();
  }
}
