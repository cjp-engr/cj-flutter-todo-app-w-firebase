import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/constants/db_constants.dart';
import 'package:first_bloc/models/todo_model.dart';
import 'package:first_bloc/pages/todos/active_todos.dart';
import 'package:first_bloc/pages/user/profile_page.dart';
import 'package:first_bloc/pages/todos/completed_todos.dart';
import 'package:first_bloc/pages/todos/todos_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    const TodosList(),
    const ActiveTodos(),
    const CompletedTodos(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isThemeLightSwitch =
        context.watch<ThemeBloc>().state.isThemeLightSwitch;
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          //color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor:
                  isThemeLightSwitch ? themeLightColor : themeDarkColor,
              color: !isThemeLightSwitch ? themeLightColor : themeDarkColor,
              tabs: [
                filterButton(context, Filter.all),
                filterButton(context, Filter.active),
                filterButton(context, Filter.completed),
                profileIcon(context),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  filterButton(BuildContext context, Filter filter) {
    return GButton(
      icon: filter == Filter.all
          ? Icons.list
          : filter == Filter.active
              ? Icons.brightness_low_outlined
              : Icons.add_alarm_sharp,
      text: filter == Filter.all
          ? 'All'
          : filter == Filter.active
              ? 'Active'
              : 'Completed',
      onPressed: () {
        //context.read<TodoFilterBloc>().changeFilter(filter);
        context
            .read<TodoFilterBloc>()
            .add(ChangeFilterEvent(newFilter: filter));
      },
      textStyle: TextStyle(
        fontSize: 18.0,
        //color: textColor(context, filter),
        fontFamily: 'Righteous',
      ),
    );
  }

  profileIcon(BuildContext context) {
    return const GButton(
      text: 'Profile',
      icon: Icons.account_circle,
      textStyle: TextStyle(
        fontSize: 18.0,
        fontFamily: 'Righteous',
        //color: Colors.blue,
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
