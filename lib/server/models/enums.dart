import 'package:flutter/material.dart';

enum AssignmentColor {
  none,
  blue(color: Colors.blue),
  red(color: Colors.red),
  green(color: Colors.green);

  const AssignmentColor({this.color});

  final Color? color;
}
