import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class AssignmentWidgetPresenter {
  final AssignmentService _service = AssignmentService();

  Future<Stream<AssignmentColor>> getCourseDefaultColor(
    Assignment assignment,
  ) async {
    return (await _service.getCourses()).map((cs) => cs
        .firstWhere((c) => c.id == assignment.courseId)
        .defaultAssignmentColor);
  }
}
