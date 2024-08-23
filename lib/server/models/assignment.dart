import 'package:calendar_v2/server/models/enums.dart';

class Assignment {
  final String id;
  String courseId;
  String name;
  AssignmentColor color;
  DateTime dueDate;
  double workRemaining;
  double percentOfGrade;
  bool isComplete;

  Assignment({
    required this.id,
    required this.courseId,
    required this.name,
    required this.color,
    required this.dueDate,
    required this.workRemaining,
    required this.percentOfGrade,
    required this.isComplete,
  });
}
