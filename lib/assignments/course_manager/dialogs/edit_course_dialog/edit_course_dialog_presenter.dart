import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class EditCourseDialogPresenter {
  final AssignmentService _service = AssignmentService();

  void updateCourse(
    String courseId,
    String name,
    AssignmentColor defaultAssignmentColor,
  ) {
    _service.updateCourse(courseId, name, defaultAssignmentColor);
  }

  void deleteCourse(String courseId) {
    _service.deleteCourse(courseId);
  }
}
