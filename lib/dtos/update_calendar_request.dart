import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/models/task.dart';

class UpdateCalendarRequest {
  final String userId;
  final String calendarId;
  final String? name;
  final TaskColor? defaultTaskColor;
  final List<Task>? tasks;

  const UpdateCalendarRequest({
    required this.userId,
    required this.calendarId,
    this.name,
    this.defaultTaskColor,
    this.tasks,
  });
}
