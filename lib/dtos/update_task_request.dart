import 'package:calendar_v2/enums.dart';

class UpdateTaskRequest {
  final String calendarId;
  final String taskId;
  final String? name;
  final TaskColor? color;
  final DateTime? dueDate;
  final double? workRemaining;
  final double? percentOfGrade;

  const UpdateTaskRequest({
    required this.calendarId,
    required this.taskId,
    this.name,
    this.color,
    this.dueDate,
    this.workRemaining,
    this.percentOfGrade,
  });
}
