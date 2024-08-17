import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/modules/calendar/calendar_service.dart';

class CalendarDayPresenter {
  final DateTime day;
  final CalendarService _service = CalendarService();

  CalendarDayPresenter(this.day);

  Stream<List<Task>> getTasks() {
    return _service
        .getFilteredTasks()
        .map((ts) => ts.where((t) => _isSameDay(day, t.dueDate)).toList());
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;
  }
}
