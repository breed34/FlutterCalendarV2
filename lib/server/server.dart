import 'package:calendar_v2/server/dtos/create_course_request.dart';
import 'package:calendar_v2/server/dtos/delete_course_request.dart';
import 'package:calendar_v2/server/dtos/update_course_request.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/temp/mock_db.dart';

class Server {
  final MockDB _db = MockDB();

  Server();

  void createCourse(CreateCourseRequest request) {
    var course = Course(
      id: request.courseId,
      name: request.name,
      defaultAssignmentColor: request.defaultAssignmentColor,
      assignments: [],
    );

    _db.entries[request.userId]!.add(course);
  }

  List<Course> getCourses(String userId) {
    return _db.entries[userId]!;
  }

  void updateCourse(UpdateCourseRequest request) {
    var existingCourseIndex = _db.entries[request.userId]!
        .indexWhere((c) => c.id == request.courseId);
    var existingCourse = _db.entries[request.userId]![existingCourseIndex];

    var newCourse = Course(
      id: existingCourse.id,
      name: request.name ?? existingCourse.name,
      defaultAssignmentColor: request.defaultAssignmentColor ??
          existingCourse.defaultAssignmentColor,
      assignments: request.assignments ?? existingCourse.assignments,
    );

    _db.entries[request.userId]![existingCourseIndex] = newCourse;
  }

  void deleteCourse(DeleteCourseRequest request) {
    _db.entries[request.userId]!.removeWhere((c) => c.id == request.courseId);
  }
}
