import 'package:flutter/material.dart';

/// Customowy dialog do dodawania nowych zadań
/// Zawiera:
/// - pole tekstowe do wpisania nazwy zadania
/// - wybór daty wykonania zadania
/// - przyciski Save i Cancel
class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final Function(DateTime?) onDateSelected;
  final DateTime? selectedDate;

  /// Tworzy nową instancję DialogBox
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.onDateSelected,
    this.selectedDate,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  /// Wyświetla dialog wyboru daty
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Theme.of(context).colorScheme.onSecondary,
              surface: Theme.of(context).colorScheme.surface,
              onSurface: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.tertiary,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nagłówek z tytułem i przyciskiem zamknięcia
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Task',
                    style: TextStyle(
                      fontSize: 24,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onCancel,
                    child: Icon(
                      Icons.close_rounded,
                      color: theme.textTheme.titleLarge?.color,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Pole tekstowe
              TextField(
                controller: widget.controller,
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  hintText: "Enter task title",
                  hintStyle: TextStyle(
                    color: theme.hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Wybór daty
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.secondary),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "Select due date (optional)"
                            : "${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}",
                        style: TextStyle(
                          color: _selectedDate == null
                              ? theme.hintColor
                              : theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: theme.hintColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Przyciski
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = null;
                        widget.onDateSelected(null);
                      });
                    },
                    child: Text(
                      "Clear Date",
                      style: TextStyle(color: theme.hintColor),
                    ),
                  ),

                  const Spacer(),

                  ElevatedButton(
                    onPressed: () {
                      if (widget.controller.text.trim().isEmpty) {
                        // Opcjonalnie: pokaż snackbar lub inną formę ostrzeżenia
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Task title cannot be empty"),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      widget.onSave();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
