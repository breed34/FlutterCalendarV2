import 'package:calendar_v2/assignments/assignment_service.dart';

class AssignmentScaffoldPresenter {
  final AssignmentService _service = AssignmentService();

  Future<void> ensureCoursesLoaded() {
    return _service.ensureCoursesLoaded();
  }
}
