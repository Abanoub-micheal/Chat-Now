import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          children: [CircularProgressIndicator(), Text('Loading....')],
        ),
      );
    },
  );
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}

void showMessage(BuildContext context, String message, String posActionText,
    Function posAction, {String? negActionText, Function? negAction}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                posAction(context);
              },
              child: Text(posActionText))
        ],
      );
    },
  );
}
