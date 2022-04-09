import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/widgets/bottom_bar.dart';
import 'package:first_bloc/widgets/logout_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isThemeLightSwitch =
        context.watch<ThemeBloc>().state.isThemeLightSwitch;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {
              logoutShowDialog(context);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dark/Light theme'),
              Switch(
                value: isThemeLightSwitch,
                onChanged: (value) {
                  context.read<ThemeBloc>().add(
                        ChangeThemeEvent(
                          isThemeLightSwitch: !isThemeLightSwitch,
                        ),
                      );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
