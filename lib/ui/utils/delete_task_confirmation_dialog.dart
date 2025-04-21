// ../ui/utils/delete_task_confirmation.dart
import 'package:flutter/material.dart';
import '../../assets/theme.dart';

Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Potwierdzenie"),
      content: const Text("Czy na pewno chcesz usunąć to zadanie?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text("Anuluj"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            "Usuń",
            style: TextStyle(color: AppColors.red),
          ),
        ),
      ],
    ),
  );

  return result ?? false;
}
