import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/assignment_dialog_presenter.dart';
import 'package:intl/intl.dart';

class EditAssignmentDialogPresenter extends AssignmentDialogPresenter {
  Future<Course> getCourseById(String courseId) async {
    return await service.getCourseById(courseId);
  }

  void updateAssignment(
    String initialCourseId,
    String assignmentId,
    String name,
    String courseId,
    String dueDate,
    AssignmentColor color,
    String workRemaing,
    String percentOfGrade,
    bool isComplete,
  ) {
    service.updateAssignment(
      initialCourseId,
      assignmentId,
      courseId,
      name,
      color,
      DateFormat('MM/dd/yyyy').parse(dueDate),
      double.parse(workRemaing),
      double.parse(percentOfGrade),
      isComplete,
    );
  }

  void deleteAssignment(String courseId, String assignmentId) {
    service.deleteAssignment(courseId, assignmentId);
  }
}
