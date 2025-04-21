import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../assets/theme.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final bool isImportant;
  final String dueDate;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final VoidCallback? onStarTap;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.isImportant,
    required this.dueDate,
    required this.onChanged,
    required this.deleteFunction,
    required this.onStarTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent, // brak koloru tła
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Ikona gwiazdki
              GestureDetector(
                onTap: onStarTap,
                child: Icon(
                  isImportant ? Icons.star : Icons.star_border,
                  color: isImportant
                      ? theme.colorScheme.secondary
                      : theme.disabledColor,
                ),
              ),
              const SizedBox(width: 10),

              // Nazwa zadania
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    color: taskCompleted
                        ? theme.disabledColor
                        : theme.textTheme.bodyLarge?.color,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),

              // Data wykonania
              if (dueDate.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    dueDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: taskCompleted
                          ? theme.disabledColor
                          : theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),

              const SizedBox(width: 10),

              // ✔️ Checkbox
              GestureDetector(
                onTap: () {
                  onChanged?.call(!taskCompleted);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: taskCompleted
                        ? AppColors.accent // Kolor akcentu dla ukończonych zadań
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: taskCompleted
                          ? theme.disabledColor // Kolor dla ukończonych zadań
                          : AppColors.secondary, // Szary kolor dla nieukończonych zadań
                      width: 2,
                    ),
                  ),
                  child: taskCompleted
                      ? const Icon(Icons.check, size: 16, color: AppColors.primary) // Kolor ikony dla ukończonych zadań
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
