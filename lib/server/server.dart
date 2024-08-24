import 'package:calendar_v2/server/dtos/create_course_request.dart';
import 'package:calendar_v2/server/dtos/delete_course_request.dart';
import 'package:calendar_v2/server/dtos/update_course_request.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Server {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Server();

  void createCourse(CreateCourseRequest request) {
    var course = Course(
      id: request.courseId,
      name: request.name,
      defaultAssignmentColor: request.defaultAssignmentColor,
      assignments: [],
    );

    _db
        .collection('courses')
        .doc(request.courseId)
        .set(course.toFirestore(request.userId));
  }

  Future<List<Course>> getCourses(String userId) async {
    var snapshot = await _db
        .collection('courses')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((d) => Course.fromFirestore(d)).toList();
  }

  void updateCourse(UpdateCourseRequest request) {
    _db.collection('courses').doc(request.courseId).update({
      if (request.name != null) 'name': request.name,
      if (request.defaultAssignmentColor != null)
        'defaultAssignmentColor': request.defaultAssignmentColor!.index,
      if (request.assignments != null)
        'assignments': request.assignments!.map((a) => a.toFirestore()),
    });
  }

  void deleteCourse(DeleteCourseRequest request) {
    _db.collection('courses').doc(request.courseId).delete();
  }
}
