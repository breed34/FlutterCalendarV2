import 'package:calendar_v2/dtos/create_task_request.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/modules/task/task_service.dart';
import 'package:intl/intl.dart';

class AddTaskDialogPresenter {
  final DateTime? initialDueDate;
  final TaskService _taskService = TaskService();

  AddTaskDialogPresenter({this.initialDueDate});

  String? getInitialDueDateValue() {
    if (initialDueDate != null) {
      return DateFormat('MM/dd/yyyy').format(initialDueDate!);
    }

    return null;
  }

  void createTask(
    String name,
    String calendarId,
    String dueDate,
    TaskColor color,
    String workRemaing,
    String importance,
  ) {
    var request = CreateTaskRequest(
      calendarId: calendarId,
      name: name,
      color: color,
      dueDate: DateFormat('MM/dd/yyyy').parse(dueDate),
      workRemaining: double.parse(workRemaing),
      importance: double.parse(importance),
    );

    _taskService.createTask(request);
  }
}
