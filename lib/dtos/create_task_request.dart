import 'package:calendar_v2/enums.dart';

class CreateTaskRequest {
  final String calendarId;
  final String name;
  final TaskColor color;
  final DateTime dueDate;
  final double workRemaining;
  final double percentOfGrade;

  const CreateTaskRequest({
    required this.calendarId,
    required this.name,
    required this.color,
    required this.dueDate,
    required this.workRemaining,
    required this.percentOfGrade,
  });
}
