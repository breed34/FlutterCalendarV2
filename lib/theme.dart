import 'package:flutter/material.dart';

var theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(backgroundColor: Colors.blue),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(visualDensity: VisualDensity.compact),
  ),
);
