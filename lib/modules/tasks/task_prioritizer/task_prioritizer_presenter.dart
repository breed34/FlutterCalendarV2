import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/modules/tasks/task_service.dart';

class TaskPrioritizerPresenter {
  final TaskService _service = TaskService();

  Stream<List<Task>> getTasksSortedByPriority() {
    return _service.getFilteredTasks().map((ts) {
      List<Task> sortedTasks = List.from(ts);
      sortedTasks.sort(_sortByPriority);
      return sortedTasks;
    });
  }

  int _sortByPriority(Task t1, Task t2) {
    var comp = _getTaskPriority(t2) - _getTaskPriority(t1);

    if (comp < 0) {
      return -1;
    } else if (comp > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  double _getTaskPriority(Task task) {
    return task.workRemaining / _daysLeft(task.dueDate) * task.importance;
  }

  double _daysLeft(DateTime dueDate) {
    var days = (dueDate.difference(DateTime.now())).inDays;
    return days > 0 ? days.toDouble() : 0.15;
  }
}
