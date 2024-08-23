import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/tasks/task_views/shared/task_dialogs/task_dialog_presenter.dart';
import 'package:intl/intl.dart';

class AddTaskDialogPresenter extends TaskDialogPresenter {
  void createTask(
    String name,
    String calendarId,
    String dueDate,
    TaskColor color,
    String workRemaing,
    String importance,
  ) {
    service.createTask(
      calendarId,
      name,
      color,
      DateFormat('MM/dd/yyyy').parse(dueDate),
      double.parse(workRemaing),
      double.parse(importance),
    );
  }
}
