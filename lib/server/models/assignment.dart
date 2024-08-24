import 'package:calendar_v2/server/models/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Assignment.fromFirestore(dynamic data) {
    return Assignment(
      id: data['id'],
      courseId: data['courseId'],
      name: data['name'],
      color: AssignmentColor.values[data['color']],
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      workRemaining: data['workRemaining'],
      percentOfGrade: data['percentOfGrade'],
      isComplete: data['isComplete'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
      'color': color.index,
      'dueDate': dueDate,
      'workRemaining': workRemaining,
      'percentOfGrade': percentOfGrade,
      'isComplete': isComplete,
    };
  }
}
