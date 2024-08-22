import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/tasks/task_service.dart';

class EditCalendarDialogPresenter {
  final TaskService _service = TaskService();

  void updateCalendar(
    String calendarId,
    String name,
    TaskColor defaultTaskColor,
  ) {
    _service.updateCalendar(calendarId, name, defaultTaskColor);
  }

  void deleteCalendar(String calendarId) {
    _service.deleteCalendar(calendarId);
  }
}
