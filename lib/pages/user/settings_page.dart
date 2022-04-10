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
    final fontSize = context.watch<FontSizeBloc>().state.fontSize;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark/Light theme',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
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
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: Text(
                    'Font Size',
                    style: Theme.of(context).textTheme.bodyText1!.merge(
                          TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                  ),
                ),
                Slider(
                  value: fontSize,
                  min: 20,
                  max: 35,
                  divisions: 5,
                  label: fontSize.round().toString(),
                  onChanged: (double value) {
                    context.read<FontSizeBloc>().add(
                          ChangeFontSizeEvent(
                            fontSize: value,
                          ),
                        );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
