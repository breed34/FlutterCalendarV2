import 'package:calendar_v2/server/models/enums.dart';

class CreateCourseRequest {
  final String userId;
  final String courseId;
  final String name;
  final AssignmentColor defaultAssignmentColor;

  const CreateCourseRequest({
    required this.courseId,
    required this.userId,
    required this.name,
    required this.defaultAssignmentColor,
  });
}
