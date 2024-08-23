import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/assignment_dialog_presenter.dart';
import 'package:intl/intl.dart';

class AddAssignmentDialogPresenter extends AssignmentDialogPresenter {
  void createAssignment(
    String name,
    String courseId,
    String dueDate,
    AssignmentColor color,
    String workRemaing,
    String percentOfGrade,
  ) {
    service.createAssignment(
      courseId,
      name,
      color,
      DateFormat('MM/dd/yyyy').parse(dueDate),
      double.parse(workRemaing),
      double.parse(percentOfGrade),
    );
  }
}
