import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:first_bloc/models/models.dart';

void errorDialog(BuildContext context, CustomError e) {
  print('code: ${e.code}\nmessage: ${e.message}\nplugin: ${e.plugin}\n');

  String errorMessage = '';

  switch (e.code) {
    case 'user-not-found':
      errorMessage = 'The user is not found';
      break;
    case 'network-request-failed':
      errorMessage = 'Network issue';
      break;
    case 'email-already-in-use':
      errorMessage = 'Email already in use';
      break;
    default:
      errorMessage = 'Unknown error';
      break;
  }

  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(e.code),
          content: Text(e.plugin + '\n' + e.message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            //e.code,
            errorMessage,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          content: Text(
            e.message,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
