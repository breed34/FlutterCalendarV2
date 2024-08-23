import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:uuid/uuid.dart';

class MockDB {
  static final MockDB _instance = MockDB._();
  final Uuid _uuid = const Uuid();
  late final Map<String, List<Course>> entries;

  MockDB._() {
    String course1Id = _uuid.v4();
    String course2Id = _uuid.v4();

    entries = {
      'abc': [
        Course(
          id: course1Id,
          name: "Course 1",
          defaultAssignmentColor: AssignmentColor.blue,
          assignments: [
            Assignment(
              id: _uuid.v4(),
              courseId: course1Id,
              name: "Assignment 1",
              color: AssignmentColor.green,
              dueDate: DateTime.parse("2024-08-20"),
              workRemaining: 12.0,
              percentOfGrade: 4,
              isComplete: true,
            ),
            Assignment(
              id: _uuid.v4(),
              courseId: course1Id,
              name: "Assignment 2",
              color: AssignmentColor.red,
              dueDate: DateTime.parse("2024-08-23"),
              workRemaining: 6.0,
              percentOfGrade: 2,
              isComplete: false,
            ),
          ],
        ),
        Course(
          id: course2Id,
          name: "Course 2",
          defaultAssignmentColor: AssignmentColor.green,
          assignments: [
            Assignment(
              id: _uuid.v4(),
              courseId: course2Id,
              name: "Assignment 3",
              color: AssignmentColor.green,
              dueDate: DateTime.parse("2024-08-21"),
              workRemaining: 12.0,
              percentOfGrade: 4,
              isComplete: false,
            ),
            Assignment(
              id: _uuid.v4(),
              courseId: course2Id,
              name: "Assignment 4",
              color: AssignmentColor.red,
              dueDate: DateTime.parse("2024-08-24"),
              workRemaining: 6.0,
              percentOfGrade: 2,
              isComplete: false,
            ),
          ],
        ),
      ]
    };
  }

  factory MockDB() => _instance;
}
