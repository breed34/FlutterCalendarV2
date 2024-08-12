import 'package:calendar_v2/data/data_handler.dart';
import 'package:calendar_v2/dtos/create_calendar_request.dart';
import 'package:calendar_v2/dtos/delete_calendar_request.dart';
import 'package:calendar_v2/dtos/update_calendar_request.dart';
import 'package:calendar_v2/models/calendar.dart';

class CalendarService {
  final DataHandler _dataHandler = DataHandler();

  void createCalendar(CreateCalendarRequest request) {
    _dataHandler.createCalendar(request);
  }

  List<Calendar> getCalendars() {
    return _dataHandler.getCalendars();
  }

  void updateCalendar(UpdateCalendarRequest request) {
    _dataHandler.updateCalendar(request);
  }

  void deleteCalendar(DeleteCalendarRequest request) {
    _dataHandler.deleteCalendar(request);
  }
}
