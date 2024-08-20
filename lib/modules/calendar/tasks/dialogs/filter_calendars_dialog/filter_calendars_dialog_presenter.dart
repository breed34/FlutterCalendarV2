import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/calendar/calendar_service.dart';
import 'package:rxdart/rxdart.dart';

class FilterCalendar {
  final Calendar calendar;
  bool show;

  FilterCalendar({
    required this.calendar,
    required this.show,
  });
}

class FilterCalendarsDialogPresenter {
  final CalendarService _service = CalendarService();

  Stream<List<FilterCalendar>> getFilterCalendars() {
    return Rx.combineLatest2(
        _service.getCalendars(),
        _service.getFilteredCalendars(),
        (cs, fcs) => cs
            .map((c) => FilterCalendar(calendar: c, show: fcs.contains(c)))
            .toList());
  }

  void hideShowCalendar(FilterCalendar calendar) {
    if (calendar.show) {
      _service.showCalendar(calendar.calendar.id);
    } else {
      _service.hideCalendar(calendar.calendar.id);
    }
  }
}
