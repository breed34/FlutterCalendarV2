import 'package:calendar_v2/server/dtos/create_calendar_request.dart';
import 'package:calendar_v2/server/dtos/delete_calendar_request.dart';
import 'package:calendar_v2/server/dtos/update_calendar_request.dart';
import 'package:calendar_v2/temp/mock_db.dart';
import 'package:calendar_v2/server/models/calendar.dart';

class Server {
  final MockDB _db = MockDB();

  Server();

  void createCalendar(CreateCalendarRequest request) {
    var calendar = Calendar(
      id: request.calendarId,
      name: request.name,
      defaultTaskColor: request.defaultTaskColor,
      tasks: [],
    );

    _db.entries[request.userId]!.add(calendar);
  }

  List<Calendar> getCalendars(String userId) {
    return _db.entries[userId]!;
  }

  void updateCalendar(UpdateCalendarRequest request) {
    var existingCalendarIndex = _db.entries[request.userId]!
        .indexWhere((c) => c.id == request.calendarId);
    var existingCalendar = _db.entries[request.userId]![existingCalendarIndex];

    var newCalendar = Calendar(
      id: existingCalendar.id,
      name: request.name ?? existingCalendar.name,
      defaultTaskColor:
          request.defaultTaskColor ?? existingCalendar.defaultTaskColor,
      tasks: request.tasks ?? existingCalendar.tasks,
    );

    _db.entries[request.userId]![existingCalendarIndex] = newCalendar;
  }

  void deleteCalendar(DeleteCalendarRequest request) {
    _db.entries[request.userId]!.removeWhere((c) => c.id == request.calendarId);
  }
}
