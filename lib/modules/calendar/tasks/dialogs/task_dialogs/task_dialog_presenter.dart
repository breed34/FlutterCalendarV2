import 'package:calendar_v2/modules/calendar/calendar_service.dart';
import 'package:intl/intl.dart';

class TaskDialogPresenter {
  final CalendarService service = CalendarService();

  String? getDueDateText(DateTime? dueDate) {
    if (dueDate != null) {
      return DateFormat('MM/dd/yyyy').format(dueDate);
    }

    return null;
  }
}
