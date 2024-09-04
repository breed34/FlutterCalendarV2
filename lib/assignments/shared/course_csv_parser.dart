import 'dart:convert';
import 'dart:typed_data';

import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CourseCSVParseException extends FormatException {
  CourseCSVParseException([super.message]);
}

class CourseCSVParser {
  static const _uuid = Uuid();
  static const _courseNameHeader = 'course_name';
  static const _nameHeader = 'name';
  static const _dueDateHeader = 'due_date';
  static const _workRemainingHeader = 'work_remaining';
  static const _percentOfGradeHeader = 'percent_of_grade';

  static Course parse(
    Uint8List fileContents, {
    required AssignmentColor defaultColor,
    required String courseId,
  }) {
    try {
      String contentsAsString = const Utf8Decoder().convert(fileContents);
      List<String> lines = contentsAsString.split('\n');

      List<String> headerLine = lines[0].split(',');
      Map<String, int> headerIndexMap = Map.fromEntries(
        headerLine.indexed
            .map((e) => MapEntry(e.$2.toLowerCase().trim(), e.$1)),
      );

      List<List<String>> bodyLines = lines
          .sublist(1)
          .map((x) => x.split(','))
          .where((x) => x.length >= 4)
          .toList();

      String courseName = bodyLines[0][headerIndexMap[_courseNameHeader]!];
      List<Assignment> assignments = bodyLines
          .map((x) => Assignment(
                id: _uuid.v4(),
                courseId: courseId,
                name: x[headerIndexMap[_nameHeader]!],
                color: defaultColor,
                dueDate:
                    DateFormat.yMd().parse(x[headerIndexMap[_dueDateHeader]!]),
                workRemaining:
                    double.parse(x[headerIndexMap[_workRemainingHeader]!]),
                percentOfGrade:
                    double.parse(x[headerIndexMap[_percentOfGradeHeader]!]),
                isComplete: false,
              ))
          .toList();

      return Course(
        id: courseId,
        name: courseName,
        defaultAssignmentColor: defaultColor,
        assignments: assignments,
      );
    } catch (e) {
      throw CourseCSVParseException("Invalid file upload.");
    }
  }
}
