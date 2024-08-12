import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/calendar/calendar_service.dart';

class CalendarManagerPresenter {
  final CalendarService _service = CalendarService();

  List<Calendar> getCalendars() {
    return _service.getCalendars();
  }
}
