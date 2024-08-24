import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class CourseDropdownWidgetPresenter {
  final AssignmentService _service = AssignmentService();

  Future<Stream<List<Course>>> getCourses() async {
    return await _service.getCourses();
  }
}
