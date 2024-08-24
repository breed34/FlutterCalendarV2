import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';
import 'package:rxdart/rxdart.dart';

class FilterCourse {
  final Course course;
  bool show;

  FilterCourse({
    required this.course,
    required this.show,
  });
}

class FilterCoursesDialogPresenter {
  final AssignmentService _service = AssignmentService();

  Future<Stream<List<FilterCourse>>> getFilterCourses() async {
    return Rx.combineLatest2(
        (await _service.getCourses()),
        (await _service.getFilteredCourses()),
        (cs, fcs) => cs
            .map((c) => FilterCourse(course: c, show: fcs.contains(c)))
            .toList());
  }

  void hideShowCourse(FilterCourse course) {
    if (course.show) {
      _service.showCourse(course.course.id);
    } else {
      _service.hideCourse(course.course.id);
    }
  }
}
