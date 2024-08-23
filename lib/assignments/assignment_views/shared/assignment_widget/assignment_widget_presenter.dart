import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class AssignmentWidgetPresenter {
  final AssignmentService _service = AssignmentService();

  Stream<AssignmentColor> getCourseDefaultColor(Assignment assignment) {
    return _service.getCourses().map((cs) => cs
        .firstWhere((c) => c.id == assignment.courseId)
        .defaultAssignmentColor);
  }
}
