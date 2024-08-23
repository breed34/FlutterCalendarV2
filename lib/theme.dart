import 'package:flutter/material.dart';

var theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(backgroundColor: Colors.blue),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      visualDensity: VisualDensity.standard,
      shape: const CircleBorder(),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    isDense: true,
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      isDense: true,
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
  ),
);
