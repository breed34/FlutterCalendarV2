import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class CalendarDayPresenter {
  final DateTime day;
  final AssignmentService _service = AssignmentService();

  CalendarDayPresenter(this.day);

  Future<Stream<List<Assignment>>> getAssignments() async {
    return (await _service.getFilteredAssignments())
        .map((ts) => ts.where((t) => _isSameDay(day, t.dueDate)).toList());
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;
  }
}
