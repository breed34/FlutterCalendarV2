import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_dialogs/task_dialog_presenter.dart';
import 'package:intl/intl.dart';

class EditTaskDialogPresenter extends TaskDialogPresenter {
  Calendar getCalendarById(String calendarId) {
    return service.getCalendarById(calendarId);
  }

  void updateTask(
    String initialCalendarId,
    String taskId,
    String name,
    String calendarId,
    String dueDate,
    TaskColor color,
    String workRemaing,
    String importance,
  ) {
    service.updateTask(
      initialCalendarId,
      taskId,
      calendarId,
      name,
      color,
      DateFormat('MM/dd/yyyy').parse(dueDate),
      double.parse(workRemaing),
      double.parse(importance),
    );
  }

  void deleteTask(String calendarId, String taskId) {
    service.deleteTask(calendarId, taskId);
  }
}
