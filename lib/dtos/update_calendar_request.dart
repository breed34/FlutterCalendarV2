import 'package:calendar_v2/models/enums.dart';

class UpdateCalendarRequest {
  final String calendarId;
  final String? name;
  final TaskColor? defaultTaskColor;

  const UpdateCalendarRequest({
    required this.calendarId,
    this.name,
    this.defaultTaskColor,
  });
}
