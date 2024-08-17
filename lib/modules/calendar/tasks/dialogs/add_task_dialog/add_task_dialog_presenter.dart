import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/modules/calendar/calendar_service.dart';
import 'package:intl/intl.dart';

class AddTaskDialogPresenter {
  final DateTime? initialDueDate;
  final CalendarService _service = CalendarService();

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
    _service.createTask(
      calendarId,
      name,
      color,
      DateFormat('MM/dd/yyyy').parse(dueDate),
      double.parse(workRemaing),
      double.parse(importance),
    );
  }
}
