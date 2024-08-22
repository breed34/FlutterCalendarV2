import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/server/models/task.dart';
import 'package:calendar_v2/tasks/task_service.dart';

class TaskWidgetPresenter {
  final TaskService _service = TaskService();

  Stream<TaskColor> getCalendarDefaultColor(Task task) {
    return _service.getCalendars().map(
        (cs) => cs.firstWhere((c) => c.id == task.calendarId).defaultTaskColor);
  }
}
