import 'dart:convert';
import 'dart:typed_data';

import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:uuid/uuid.dart';

class CreateCourseRequest {
  final String userId;
  final String courseId;
  final String name;
  final AssignmentColor defaultAssignmentColor;
  List<Assignment>? assignments;

  CreateCourseRequest({
    required this.courseId,
    required this.userId,
    required this.name,
    required this.defaultAssignmentColor,
    this.assignments,
  });
}
