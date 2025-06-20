import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/assignments/assignment_service.dart';

class AssignmentPrioritizerPresenter {
  final AssignmentService _service = AssignmentService();

  Stream<List<Assignment>> getAssignmentsSortedByPriority() {
    return _service.getFilteredAssignments().map((ts) {
      List<Assignment> sortedAssignments = List.from(ts);
      sortedAssignments.sort(_sortByPriorityDesc);
      return sortedAssignments;
    });
  }

  int _sortByPriorityDesc(Assignment a1, Assignment a2) {
    var comp = _getAssignmentPriority(a2) - _getAssignmentPriority(a1);

    if (comp < 0) {
      return -1;
    } else if (comp > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  double _getAssignmentPriority(Assignment assignment) {
    return (36500 - _daysLeft(assignment.dueDate)) *
        (assignment.isComplete ? 0 : 1);
  }

  double _daysLeft(DateTime dueDate) {
    var days = (dueDate.difference(DateTime.now())).inDays;
    return days.toDouble();
  }
}
