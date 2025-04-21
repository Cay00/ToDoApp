import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../assets/theme.dart';
import '../../assets/theme_provider.dart';
import '../../controllers/task_controller.dart';
import '../widgets/task_list.dart';
import '../widgets/welcome_text.dart';
import '../utils/dialog_box.dart';
import '../widgets/top_nav_bar.dart';
import '../utils/name_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = TaskController();
  String _name = 'Chris';

  @override
  void initState() {
    _taskController.initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: TopNavBar(_changeName),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () => _showAddDialog(context),
        child: Icon(
          Icons.add,
          color: themeProvider.isDarkMode ? AppColors.primary : AppColors.lightPrimary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            WelcomeText(name: _name),
            const SizedBox(height: 20),
            Expanded(
              child: TaskList(controller: _taskController),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _taskController.controller,
          selectedDate: _taskController.selectedDate,
          onDateSelected: (date) {
            setState(() {
              _taskController.setTaskDate(date);
            });
          },
          onSave: () {
            setState(() {
              _taskController.addTask();
            });
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void _changeName() {
    showNameBottomSheet(
      context: context,
      currentName: _name,
      onNameChanged: (newName) {
        setState(() {
          _name = newName;
        });
      },
    );
  }
}