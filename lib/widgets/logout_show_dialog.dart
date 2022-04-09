import 'package:first_bloc/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future logoutShowDialog(BuildContext context) {
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
          'Do you really want to logout?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
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
}
