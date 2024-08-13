import 'package:calendar_v2/modules/task/task_calendar/calendar_widget/calendar_day_widget/calendar_day_presenter.dart';
import 'package:intl/intl.dart';

class CalendarDayDialogPresenter extends CalendarDayPresenter {
  CalendarDayDialogPresenter(super.day);

  String getFormattedDate() {
    return DateFormat.yMMMd().format(day);
  }
}
