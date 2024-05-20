import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Not Implemented'),
      content: const Text('This feature is not implemented yet.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
