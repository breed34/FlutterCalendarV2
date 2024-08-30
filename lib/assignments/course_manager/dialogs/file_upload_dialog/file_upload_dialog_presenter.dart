import 'dart:typed_data';

import 'package:calendar_v2/assignments/assignment_service.dart';
import 'package:calendar_v2/server/models/enums.dart';

class FileUploadDialogPresenter {
  final AssignmentService _service = AssignmentService();

  void createCourseFromFile(
    Uint8List bytes,
    AssignmentColor defaultColor,
  ) {
    _service.uploadCourse(bytes, defaultColor);
  }
}
