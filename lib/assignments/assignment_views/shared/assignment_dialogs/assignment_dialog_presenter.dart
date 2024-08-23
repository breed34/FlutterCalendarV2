import 'package:calendar_v2/assignments/assignment_service.dart';
import 'package:intl/intl.dart';

class AssignmentDialogPresenter {
  final AssignmentService service = AssignmentService();

  String? getDueDateText(DateTime? dueDate) {
    if (dueDate != null) {
      return DateFormat('MM/dd/yyyy').format(dueDate);
    }

    return null;
  }
}
