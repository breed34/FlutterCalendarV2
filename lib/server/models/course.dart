import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Course.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    var assignmentDatas = (data!['assignments'] is Iterable
        ? data['assignments']
        : []) as Iterable;

    return Course(
      id: snapshot.id,
      name: data['name'],
      defaultAssignmentColor:
          AssignmentColor.values[data['defaultAssignmentColor']],
      assignments:
          assignmentDatas.map((a) => Assignment.fromFirestore(a)).toList(),
    );
  }

  Map<String, dynamic> toFirestore(String userId) {
    return {
      'userId': userId,
      'name': name,
      'defaultAssignmentColor': defaultAssignmentColor.index,
      'assignments': assignments.map((a) => a.toFirestore()),
    };
  }
}
