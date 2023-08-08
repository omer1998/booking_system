import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showMyDialog(BuildContext context, String msg, [VoidCallback? onAction, String? actionName]) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(msg),
        actions: [
          ElevatedButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          onAction != null ? ElevatedButton(
              child: Text(actionName!),
              onPressed: () {
                onAction();
              }) : 
          Container(),

        ],
      );
    },
  );
}
