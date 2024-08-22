import 'package:calendar_v2/server/models/calendar.dart';
import 'package:calendar_v2/tasks/task_service.dart';

class CalendarDropdownWidgetPresenter {
  final TaskService _service = TaskService();

  Stream<List<Calendar>> getCalendars() {
    return _service.getCalendars();
  }
}
