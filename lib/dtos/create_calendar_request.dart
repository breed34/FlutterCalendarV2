import 'package:calendar_v2/models/enums.dart';

class CreateCalendarRequest {
  final String userId;
  final String name;
  final TaskColor defaultTaskColor;

  const CreateCalendarRequest({
    required this.userId,
    required this.name,
    required this.defaultTaskColor,
  });
}
