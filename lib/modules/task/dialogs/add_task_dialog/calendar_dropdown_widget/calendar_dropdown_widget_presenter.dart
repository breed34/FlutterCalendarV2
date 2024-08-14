import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/task/task_service.dart';

class CalendarDropdownWidgetPresenter {
  final TaskService _service = TaskService();

  List<Calendar> getCalendars() {
    return _service.getAllCalendars();
  }
}
