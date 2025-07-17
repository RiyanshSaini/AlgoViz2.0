
import 'package:flutter/material.dart';

Future<String?> showNodeInputDialog(BuildContext context) async {
  String? value;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Node'),
      content: TextField(
        onChanged: (v) => value = v,
        decoration: const InputDecoration(hintText: 'Enter node value'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, value),
          child: const Text('Add'),
        ),
      ],
    ),
  );
  return value;
}