import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromRGBO(46, 204, 113, 1),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 60,
      ),
      displayMedium: TextStyle(
        fontSize: 50,
      ),
      titleMedium: TextStyle(
        fontSize: 30,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
      ),
    ),
  );
}
