import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(16),
      );

  // 🌞 LIGHT THEME
  static final lightThemeMode = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: Colors.white,

    colorScheme: const ColorScheme.light(
      primary: AppPallete.secondaryColor,
      error: AppPallete.errorColor,
      secondary: AppPallete.blackColor,
    ),

    appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(AppPallete.blackColor),
      focusedBorder: _border(AppPallete.secondaryColor),
      errorBorder: _border(AppPallete.errorColor),
      contentPadding: const EdgeInsets.all(20),
    ),
    iconTheme: const IconThemeData(color: AppPallete.blackColor),

    textTheme: _lightTextTheme,
  );

  // 🌙 DARK THEME
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,

    colorScheme: const ColorScheme.dark(
      primary: AppPallete.secondaryColor,
      error: AppPallete.errorColor,
      secondary: AppPallete.whiteColor,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
    ),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.secondaryColor),
      errorBorder: _border(AppPallete.errorColor),
      contentPadding: const EdgeInsets.all(20),
    ),
    iconTheme: const IconThemeData(color: AppPallete.whiteColor),

    textTheme: _darkTextTheme,
  );

  // ✍️ TEXT THEMES
  static const _lightTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),

    titleLarge: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
     bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
    bodySmall:  TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w400,
    ),
  );

  static const _darkTextTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
     headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
    bodySmall:  TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    ),
  );
}
