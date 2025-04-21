import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WelcomeText extends StatelessWidget {
  final String name;

  const WelcomeText({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d').format(DateTime.now());
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: textTheme.titleLarge,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Today is',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 5),
            Text(
              formattedDate,
              style: textTheme.titleLarge,
            ),
          ],
        ),
      ],
    );
  }
}