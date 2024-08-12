import 'package:calendar_v2/modules/task/task_calendar/task_calendar_view.dart';
import 'package:calendar_v2/modules/user/login/login_view.dart';

var routes = {
  '/': (context) => LoginView(),
  '/tasks/calendar': (context) => TaskCalendarView(),
};
