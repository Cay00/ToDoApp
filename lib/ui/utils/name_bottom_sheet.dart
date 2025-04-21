import 'package:flutter/material.dart';

void showNameBottomSheet({
  required BuildContext context,
  required String currentName,
  required Function(String) onNameChanged,
}) {
  final TextEditingController nameController =
  TextEditingController(text: currentName);
  final theme = Theme.of(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: theme.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change your name',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  hintText: 'Your name',
                  hintStyle: TextStyle(
                    color: theme.hintColor,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.secondary),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.secondary),
                  ),
                ),
                cursorColor: theme.colorScheme.secondary,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  final String newName = nameController.text.trim();
                  if (newName.isNotEmpty) {
                    onNameChanged(newName);
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: theme.colorScheme.onSecondary),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
