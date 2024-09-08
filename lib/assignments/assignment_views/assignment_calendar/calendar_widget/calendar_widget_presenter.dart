import 'package:intl/intl.dart';

class CalendarWidgetPresenter {
  final int numCalendarRows = 6;
  final DateTime monthFirstDay;

  CalendarWidgetPresenter({required this.monthFirstDay});

  List<String> getAbbreviatedDays() {
    var currDay = _lastMonday(monthFirstDay).toUtc();
    List<String> abbreviatedDays = [];
    for (int i = 0; i < DateTime.daysPerWeek; i++) {
      abbreviatedDays.add(DateFormat.E().format(currDay));
      currDay = currDay.add(const Duration(days: 1));
    }

    return abbreviatedDays;
  }

  List<List<DateTime>> getCellDays() {
    var currDay = _lastMonday(monthFirstDay).toUtc();
    List<List<DateTime>> grid = [];
    for (int i = 0; i < numCalendarRows; i++) {
      grid.add([]);
      for (int j = 0; j < DateTime.daysPerWeek; j++) {
        grid[i].add(currDay);
        currDay = currDay.add(const Duration(days: 1));
      }
    }

    return grid;
  }

  bool isToday(DateTime day) {
    var today = DateTime.now();
    return day.month == today.month &&
        day.year == today.year &&
        day.day == today.day;
  }

  bool isInCurrentMonth(DateTime day) {
    return day.month == monthFirstDay.month && day.year == monthFirstDay.year;
  }

  DateTime _lastMonday(DateTime day) {
    var currDay = day.toUtc();
    while (currDay.weekday != DateTime.monday) {
      currDay = currDay.subtract(const Duration(days: 1));
    }

    return currDay;
  }
}
