import 'package:calendar_v2/enums.dart';

class Task {
  final String id;
  final String name;
  final TaskColor color;
  final DateTime dueDate;
  final double workRemaining;
  final double percentOfGrade;

  const Task({
    required this.id,
    required this.name,
    required this.color,
    required this.dueDate,
    required this.workRemaining,
    required this.percentOfGrade,
  });
}
