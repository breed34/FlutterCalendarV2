import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class AddCourseDialogPresenter {
  final AssignmentService _service = AssignmentService();

  void createCourse(String name, AssignmentColor defaultAssignmentColor) {
    _service.createCourse(name, defaultAssignmentColor);
  }
}
