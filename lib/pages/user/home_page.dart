import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _getInitialTodos();
    super.initState();
  }

  void _getInitialTodos() {
    context.read<TodoListBloc>().add(InitialLoadTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: BottomBar(),
      ),
    );
  }
}
