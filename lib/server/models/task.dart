import 'package:calendar_v2/server/models/enums.dart';

class Task {
  final String id;
  String calendarId;
  String name;
  TaskColor color;
  DateTime dueDate;
  double workRemaining;
  double importance;
  bool isComplete;

  Task({
    required this.id,
    required this.calendarId,
    required this.name,
    required this.color,
    required this.dueDate,
    required this.workRemaining,
    required this.importance,
    required this.isComplete,
  });
}
