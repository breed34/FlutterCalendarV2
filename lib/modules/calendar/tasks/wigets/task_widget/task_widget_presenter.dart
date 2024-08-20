import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/modules/calendar/calendar_service.dart';

class TaskWidgetPresenter {
  final CalendarService _service = CalendarService();

  Stream<TaskColor> getCalendarDefaultColor(Task task) {
    return _service.getCalendars().map(
        (cs) => cs.firstWhere((c) => c.id == task.calendarId).defaultTaskColor);
  }
}
