import 'package:calendar_v2/server/models/enums.dart';

class CreateCalendarRequest {
  final String userId;
  final String calendarId;
  final String name;
  final TaskColor defaultTaskColor;

  const CreateCalendarRequest({
    required this.calendarId,
    required this.userId,
    required this.name,
    required this.defaultTaskColor,
  });
}
