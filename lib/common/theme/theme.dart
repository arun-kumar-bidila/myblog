import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(16),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.secondaryColor),
      errorBorder: _border(AppPallete.errorColor),
      contentPadding: .all(27),
      
      
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
  );
}
