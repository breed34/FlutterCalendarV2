import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/enums.dart';

class Course {
  final String id;
  String name;
  AssignmentColor defaultAssignmentColor;
  List<Assignment> assignments;

  Course({
    required this.id,
    required this.name,
    required this.defaultAssignmentColor,
    required this.assignments,
  });
}
