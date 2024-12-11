import 'package:flutter/material.dart';
import 'package:oriflamenepal/config/color/app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
    ),
    // primaryColor: kprimaryColor,
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kprimaryColor,
      primary: kprimaryColor,
      brightness: Brightness.light,
    ),
  );
}
