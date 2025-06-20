import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class AssignmentCalendarPresenter {
  final int initialPageIndex = 9999;
  late final DateTime _todayMonthFirstDay;
  late int _currentPageIndex;

  AssignmentCalendarPresenter() {
    var today = DateTime.now();
    _todayMonthFirstDay = DateTime(today.year, today.month);
    _currentPageIndex = initialPageIndex;
  }

  void setCurrentPageIndex(int value) {
    _currentPageIndex = value;
  }

  String getCurrentMonthString() {
    return DateFormat.MMMM().format(getCurrentMonthFirstDay());
  }

  String getCurrentYearString() {
    return DateFormat.y().format(getCurrentMonthFirstDay());
  }

  DateTime getCurrentMonthFirstDay() {
    return Jiffy.parseFromDateTime(_todayMonthFirstDay)
        .add(months: _currentPageIndex - initialPageIndex)
        .dateTime;
  }
}
