import 'package:calendar_v2/server/models/calendar.dart';
import 'package:calendar_v2/tasks/task_service.dart';

class CalendarManagerPresenter {
  final TaskService _service = TaskService();

  Stream<List<Calendar>> getCalendars() {
    return _service.getCalendars();
  }
}
