import 'package:flutter/material.dart';

enum AssignmentColor {
  none,
  lightBlue(
    displayName: 'Light Blue',
    color: Color.fromARGB(255, 68, 196, 255),
  ),
  blue(
    displayName: 'Royal Blue',
    color: Colors.blue,
  ),
  darkBlue(
    displayName: 'Navy Blue',
    color: Color.fromARGB(255, 7, 88, 155),
  ),
  lightRed(
    displayName: 'Salmon',
    color: Color.fromARGB(255, 255, 147, 139),
  ),
  red(
    displayName: 'Red',
    color: Colors.red,
  ),
  darkRed(
    displayName: 'Crimson',
    color: Color.fromARGB(255, 132, 20, 12),
  ),
  lightGreen(
    displayName: 'Light Green',
    color: Color.fromARGB(255, 136, 207, 95),
  ),
  green(
    displayName: 'Green',
    color: Colors.green,
  ),
  darkGreen(
    displayName: 'Forest Green',
    color: Color.fromARGB(255, 36, 113, 39),
  ),
  lightYellow(
    displayName: 'Light Yellow',
    color: Color.fromARGB(255, 253, 240, 58),
  ),
  yellow(
    displayName: 'Yellow',
    color: Color.fromARGB(255, 237, 219, 50),
  ),
  darkYellow(
    displayName: 'Gold',
    color: Color.fromARGB(255, 183, 167, 27),
  ),
  pink(
    displayName: 'Pink',
    color: Color.fromARGB(255, 253, 141, 253),
  ),
  purple(
    displayName: 'Purple',
    color: Color.fromARGB(255, 144, 33, 164),
  );

  const AssignmentColor({this.displayName, this.color});

  final String? displayName;
  final Color? color;
}
