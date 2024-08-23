import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/enums.dart';

class UpdateCourseRequest {
  final String userId;
  final String courseId;
  final String? name;
  final AssignmentColor? defaultAssignmentColor;
  final List<Assignment>? assignments;

  const UpdateCourseRequest({
    required this.userId,
    required this.courseId,
    this.name,
    this.defaultAssignmentColor,
    this.assignments,
  });
}
