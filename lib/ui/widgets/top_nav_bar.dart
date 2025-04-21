import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../assets/theme.dart';
import '../../assets/theme_provider.dart';

AppBar TopNavBar(VoidCallback onIconTap) {
  return AppBar(
    title: Builder(
        builder: (context) {
          return Text(
            '365.',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          );
        }
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    leading: Builder(
        builder: (context) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: AppColors.accent,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          );
        }
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.account_circle_outlined, color: AppColors.accent),
        onPressed: onIconTap,
        padding: const EdgeInsets.only(right: 10),
      ),
    ],
  );
}