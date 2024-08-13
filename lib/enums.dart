import 'package:flutter/material.dart';

enum TaskColor {
  none,
  blue(color: Colors.blue),
  red(color: Colors.red),
  green(color: Colors.green);

  const TaskColor({this.color});

  final Color? color;
}
