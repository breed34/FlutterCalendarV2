import 'package:calendar_v2/models/calendar.dart';

class User {
  final String id;
  final String username;
  final List<Calendar> calendars;

  const User({
    required this.id,
    required this.username,
    required this.calendars,
  });
}
