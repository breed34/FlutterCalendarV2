import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/modules/tasks/task_service.dart';

class AddCalendarDialogPresenter {
  final TaskService _service = TaskService();

  void createCalendar(String name, TaskColor defaultTaskColor) {
    _service.createCalendar(name, defaultTaskColor);
  }
}
