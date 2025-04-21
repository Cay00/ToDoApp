import 'package:flutter/material.dart';

class AppColors {
  // Bazowe kolory
  static const Color primary = Color(0xFF0D0D0D);     // ciemny kolor tła
  static const Color secondary = Color(0xFF686868);   // kolor secondary dla tekstu
  static const Color tertiary = Color(0xFF1E1E1E);    // ciemny kolor drugorzędny
  static const Color accent = Color(0xFFA8CF38);      // kolor akcentu
  static const Color red = Color(0xFFF70F62);         // kolor dla alertów/błędów
  static const Color white = Color(0xFFFFFFFF);       // biały kolor

  // Kolory dla jasnego motywu
  static const Color lightPrimary = Color(0xFFFFFFFF);  // jasny kolor tła
  static const Color lightTertiary = Color(0xFFF5F5F5); // jasny kolor drugorzędny
  static const Color darkText = Color(0xFF0D0D0D);      // ciemny kolor tekstu dla jasnego motywu
}

class AppTheme {
  // Ciemny motyw
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.accent),
      titleTextStyle: TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.normal),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.white, fontSize: 24, fontWeight: FontWeight.normal),
      titleMedium: TextStyle(color: AppColors.secondary, fontSize: 16, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(color: AppColors.white, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.normal),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.accent,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.accent,
      surface: AppColors.primary,
    ),
  );

  // Jasny motyw
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.accent),
      titleTextStyle: TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.normal),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.normal),
      titleMedium: TextStyle(color: AppColors.secondary, fontSize: 16, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(color: AppColors.primary, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.normal),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.accent,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.accent,
      secondary: AppColors.accent,
      surface: AppColors.lightTertiary,
    ),
  );
}
