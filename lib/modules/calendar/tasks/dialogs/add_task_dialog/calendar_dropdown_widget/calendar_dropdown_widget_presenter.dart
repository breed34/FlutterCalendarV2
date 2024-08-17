import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/calendar/calendar_service.dart';

class CalendarDropdownWidgetPresenter {
  final CalendarService _service = CalendarService();

  Stream<List<Calendar>> getCalendars() {
    return _service.getCalendars();
  }
}
