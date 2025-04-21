import 'package:flutter/material.dart';
import '../../assets/theme.dart';
import '../../controllers/task_controller.dart';
import '../utils/todo_tile.dart';
import '../utils/delete_task_confirmation_dialog.dart';

/// Widget wyświetlający listę zadań pogrupowanych w sekcje:
/// - Important (ważne zadania)
/// - My Tasks (standardowe zadania)
/// - Done (wykonane zadania)
class TaskList extends StatefulWidget {
  /// Kontroler zarządzający operacjami na zadaniach
  final TaskController controller;

  /// Tworzy nową instancję TaskList
  const TaskList({super.key, required this.controller});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final List doneTasks =
    widget.controller.toDoList.where((task) => task[1] == true).toList();

    final List importantTasks = widget.controller.toDoList
        .where((task) => task.length > 2 && task[2] == true && task[1] == false)
        .toList();

    final List normalTasks = widget.controller.toDoList
        .where((task) =>
    (!(task.length > 2 && task[2] == true)) && task[1] == false)
        .toList();

    // Budujemy dynamicznie wszystkie widżety do wyświetlenia w liście
    final List<Widget> taskWidgets = [];

    if (importantTasks.isNotEmpty) {
      taskWidgets.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Text("Important",
            style: TextStyle(fontSize: 16, color: AppColors.accent)),
      ));
      taskWidgets.addAll(importantTasks.map((task) {
        final index = widget.controller.toDoList.indexOf(task);
        return ToDoTile(
          taskName: task[0],
          taskCompleted: task[1],
          isImportant: true,
          dueDate: widget.controller.getTaskDateString(index),
          onChanged: (value) {
            setState(() {
              widget.controller.toggleTask(index);
            });
          },
          onStarTap: () {
            setState(() {
              widget.controller.toggleImportant(index);
            });
          },
          deleteFunction: (context) async {
            final confirmed = await showDeleteConfirmationDialog(context);
            if (confirmed) {
              setState(() {
                widget.controller.deleteTask(index);
              });
            }
          },
        );
      }));
    }

    if (importantTasks.isNotEmpty && normalTasks.isNotEmpty) {
      taskWidgets.add(const Divider(thickness: 1, height: 32, color: AppColors.tertiary));
    }

    if (normalTasks.isNotEmpty) {
      taskWidgets.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Text("My Tasks",
            style: TextStyle(fontSize: 16, color: AppColors.secondary)),
      ));
      taskWidgets.addAll(normalTasks.map((task) {
        final index = widget.controller.toDoList.indexOf(task);
        return ToDoTile(
          taskName: task[0],
          taskCompleted: task[1],
          isImportant: task.length > 2 ? task[2] : false,
          dueDate: widget.controller.getTaskDateString(index),
          onChanged: (value) {
            setState(() {
              widget.controller.toggleTask(index);
            });
          },
          onStarTap: () {
            setState(() {
              widget.controller.toggleImportant(index);
            });
          },
          deleteFunction: (context) async {
            final confirmed = await showDeleteConfirmationDialog(context);
            if (confirmed) {
              setState(() {
                widget.controller.deleteTask(index);
              });
            }
          },
        );
      }));
    }

    if ((importantTasks.isNotEmpty || normalTasks.isNotEmpty) &&
        doneTasks.isNotEmpty) {
      taskWidgets.add(const Divider(thickness: 1, height: 32, color: AppColors.tertiary));
    }

    if (doneTasks.isNotEmpty) {
      taskWidgets.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Text("Done",
            style: TextStyle(fontSize: 16, color: AppColors.secondary)),
      ));
      taskWidgets.addAll(doneTasks.map((task) {
        final index = widget.controller.toDoList.indexOf(task);
        return ToDoTile(
          taskName: task[0],
          taskCompleted: true,
          isImportant: task.length > 2 ? task[2] : false,
          dueDate: widget.controller.getTaskDateString(index),
          onChanged: (value) {
            setState(() {
              widget.controller.toggleTask(index);
            });
          },
          onStarTap: () {
            setState(() {
              widget.controller.toggleImportant(index);
            });
          },
          deleteFunction: (context) async {
            final confirmed = await showDeleteConfirmationDialog(context);
            if (confirmed) {
              setState(() {
                widget.controller.deleteTask(index);
              });
            }
          },
        );
      }));
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: taskWidgets,
    );
  }
}