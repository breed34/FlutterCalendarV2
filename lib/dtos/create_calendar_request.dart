import 'package:calendar_v2/enums.dart';

class CreateCalendarRequest {
  final String name;
  final TaskColor defaultTaskColor;

  const CreateCalendarRequest({
    required this.name,
    required this.defaultTaskColor,
  });
}
