import 'package:calendar_v2/server/models/calendar.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/tasks/task_views/shared/task_dialogs/task_dialog_presenter.dart';
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
    bool isComplete,
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
      isComplete,
    );
  }

  void deleteTask(String calendarId, String taskId) {
    service.deleteTask(calendarId, taskId);
  }
}
