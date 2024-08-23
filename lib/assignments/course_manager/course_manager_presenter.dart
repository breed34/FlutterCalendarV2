import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class CourseManagerPresenter {
  final AssignmentService _service = AssignmentService();

  Stream<List<Course>> getCourses() {
    return _service.getCourses();
  }
}
