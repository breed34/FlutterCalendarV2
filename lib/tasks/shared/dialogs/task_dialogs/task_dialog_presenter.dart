import 'package:calendar_v2/tasks/task_service.dart';
import 'package:intl/intl.dart';

class TaskDialogPresenter {
  final TaskService service = TaskService();

  String? getDueDateText(DateTime? dueDate) {
    if (dueDate != null) {
      return DateFormat('MM/dd/yyyy').format(dueDate);
    }

    return null;
  }
}
