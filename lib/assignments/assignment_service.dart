import 'package:calendar_v2/server/dtos/create_course_request.dart';
import 'package:calendar_v2/server/dtos/delete_course_request.dart';
import 'package:calendar_v2/server/dtos/update_course_request.dart';
import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/server/server.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class AssignmentService {
  static final AssignmentService _instance = AssignmentService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Server _server = Server();
  final Uuid _uuid = const Uuid();
  final BehaviorSubject<List<String>> _courseIdsToHide =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Course>> _courses =
      BehaviorSubject<List<Course>>();

  AssignmentService._();

  factory AssignmentService() => _instance;

  void createAssignment(
    String courseId,
    String name,
    AssignmentColor color,
    DateTime dueDate,
    double workRemaining,
    double percentOfGrade,
  ) {
    List<Course> courses = List.from(_courses.value);
    Course ccourseToUpdate = courses.firstWhere((c) => c.id == courseId);

    ccourseToUpdate.assignments.add(Assignment(
      id: _uuid.v4(),
      courseId: ccourseToUpdate.id,
      name: name,
      color: color,
      dueDate: dueDate,
      workRemaining: workRemaining,
      percentOfGrade: percentOfGrade,
      isComplete: false,
    ));

    _courses.sink.add(courses);
    _server.updateCourse(UpdateCourseRequest(
      userId: _auth.currentUser!.uid,
      courseId: ccourseToUpdate.id,
      assignments: ccourseToUpdate.assignments,
    ));
  }

  Stream<List<Assignment>> getFilteredAssignments() {
    return getFilteredCourses()
        .map((cs) => cs.expand((c) => c.assignments).toList());
  }

  void updateAssignment(
    String currentCourseId,
    String assignmentId,
    String? newCourseId,
    String? name,
    AssignmentColor? color,
    DateTime? dueDate,
    double? workRemaining,
    double? percentOfGrade,
    bool? isComplete,
  ) {
    List<Course> courses = List.from(_courses.value);
    Course currentCourseToUpdate =
        courses.firstWhere((c) => c.id == currentCourseId);

    Assignment assignmentToUpdate = currentCourseToUpdate.assignments
        .firstWhere((a) => a.id == assignmentId);

    assignmentToUpdate.name = name ?? assignmentToUpdate.name;
    assignmentToUpdate.color = color ?? assignmentToUpdate.color;
    assignmentToUpdate.dueDate = dueDate ?? assignmentToUpdate.dueDate;
    assignmentToUpdate.workRemaining =
        workRemaining ?? assignmentToUpdate.workRemaining;
    assignmentToUpdate.percentOfGrade =
        percentOfGrade ?? assignmentToUpdate.percentOfGrade;
    assignmentToUpdate.isComplete = isComplete ?? assignmentToUpdate.isComplete;

    if (newCourseId != null && currentCourseId != newCourseId) {
      Course newCourseToUpdate = courses.firstWhere((c) => c.id == newCourseId);
      assignmentToUpdate.courseId = newCourseToUpdate.id;
      currentCourseToUpdate.assignments
          .removeWhere((a) => a.id == assignmentToUpdate.id);
      newCourseToUpdate.assignments.add(assignmentToUpdate);

      _server.updateCourse(UpdateCourseRequest(
        userId: _auth.currentUser!.uid,
        courseId: newCourseToUpdate.id,
        assignments: newCourseToUpdate.assignments,
      ));
    }

    _courses.sink.add(courses);
    _server.updateCourse(UpdateCourseRequest(
      userId: _auth.currentUser!.uid,
      courseId: currentCourseToUpdate.id,
      assignments: currentCourseToUpdate.assignments,
    ));
  }

  void deleteAssignment(String courseId, String assignmentId) {
    List<Course> courses = List.from(_courses.value);
    Course courseToUpdate = courses.firstWhere((c) => c.id == courseId);

    courseToUpdate.assignments.removeWhere((a) => a.id == assignmentId);

    _courses.sink.add(courses);
    _server.updateCourse(UpdateCourseRequest(
      userId: _auth.currentUser!.uid,
      courseId: courseToUpdate.id,
      assignments: courseToUpdate.assignments,
    ));
  }

  void createCourse(String name, AssignmentColor defaultAssignmentColor) {
    List<Course> courses = List.from(_courses.value);
    String courseId = _uuid.v4();
    courses.add(Course(
      id: courseId,
      name: name,
      defaultAssignmentColor: defaultAssignmentColor,
      assignments: [],
    ));

    _courses.sink.add(courses);
    _server.createCourse(CreateCourseRequest(
      userId: _auth.currentUser!.uid,
      courseId: courseId,
      name: name,
      defaultAssignmentColor: defaultAssignmentColor,
    ));
  }

  Course getCourseById(String courseId) {
    return _courses.value.firstWhere((c) => c.id == courseId);
  }

  Stream<List<Course>> getCourses() {
    return _courses.stream;
  }

  Stream<List<Course>> getFilteredCourses() {
    return Rx.combineLatest2(_courses.stream, _courseIdsToHide,
        (cs, cids) => cs.where((c) => !cids.contains(c.id)).toList());
  }

  void updateCourse(
    String courseId,
    String? name,
    AssignmentColor? defaultAssignmentColor,
  ) {
    List<Course> courses = List.from(_courses.value);
    Course courseToUpdate = courses.firstWhere((c) => c.id == courseId);

    courseToUpdate.name = name ?? courseToUpdate.name;
    courseToUpdate.defaultAssignmentColor =
        defaultAssignmentColor ?? courseToUpdate.defaultAssignmentColor;

    _courses.sink.add(courses);
    _server.updateCourse(UpdateCourseRequest(
      userId: _auth.currentUser!.uid,
      courseId: courseId,
      name: courseToUpdate.name,
      defaultAssignmentColor: courseToUpdate.defaultAssignmentColor,
    ));
  }

  void hideCourse(String courseId) {
    var courseIds = _courseIdsToHide.value;
    courseIds.add(courseId);
    _courseIdsToHide.sink.add(courseIds);
  }

  void showCourse(String courseId) {
    var courseIds = _courseIdsToHide.value;
    courseIds.remove(courseId);
    _courseIdsToHide.sink.add(courseIds);
  }

  void deleteCourse(String courseId) {
    List<Course> courses = List.from(_courses.value);
    courses.removeWhere((c) => c.id == courseId);

    _courses.sink.add(courses);
    _server.deleteCourse(DeleteCourseRequest(
      userId: _auth.currentUser!.uid,
      courseId: courseId,
    ));
  }

  Future<void> ensureCoursesLoaded() async {
    if (!_courses.hasValue) {
      var courses = await _server.getCourses(_auth.currentUser!.uid);
      _courses.sink.add(courses);
    }
  }
}
