import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/tasks/task_service.dart';

class CalendarDropdownWidgetPresenter {
  final TaskService _service = TaskService();

  Stream<List<Calendar>> getCalendars() {
    return _service.getCalendars();
  }
}
