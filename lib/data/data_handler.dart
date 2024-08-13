import 'package:calendar_v2/dtos/create_calendar_request.dart';
import 'package:calendar_v2/dtos/create_task_request.dart';
import 'package:calendar_v2/dtos/delete_calendar_request.dart';
import 'package:calendar_v2/dtos/delete_task_request.dart';
import 'package:calendar_v2/dtos/update_calendar_request.dart';
import 'package:calendar_v2/dtos/update_task_request.dart';
import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/models/user.dart';
import 'package:calendar_v2/data/server.dart';

class DataHandler {
  static final DataHandler _instance = DataHandler._();

  final Server _server = Server();
  User? currentUser;

  DataHandler._();

  factory DataHandler() => _instance;

  // User Operations
  void login() {
    currentUser = _server.loginUser();
  }

  void register() {
    currentUser = _server.registerUser();
  }

  void logout() {
    _server.logoutUser();
    currentUser = null;
  }

  // Calendar Operations
  void createCalendar(CreateCalendarRequest request) {
    _server.createCalendar(request);
    _reloadLoggedInUser();
  }

  List<Calendar> getCalendars() {
    if (currentUser == null) {
      _reloadLoggedInUser();
    }

    return currentUser!.calendars;
  }

  void updateCalendar(UpdateCalendarRequest request) {
    _server.updateCalendar(request);
    _reloadLoggedInUser();
  }

  void deleteCalendar(DeleteCalendarRequest request) {
    _server.deleteCalendar(request);
    _reloadLoggedInUser();
  }

  // Task Operations
  void createTask(CreateTaskRequest request) {
    _server.createTask(request);
    _reloadLoggedInUser();
  }

  List<Task> getFilteredTasks(Set<String> calendarIdsToHide) {
    if (currentUser == null) {
      _reloadLoggedInUser();
    }

    return currentUser!.calendars
        .where((c) => !calendarIdsToHide.contains(c.id))
        .expand((c) => c.tasks)
        .toList();
  }

  void updateTask(UpdateTaskRequest request) {
    _server.updateTask(request);
    _reloadLoggedInUser();
  }

  void deleteTask(DeleteTaskRequest request) {
    _server.deleteTask(request);
    _reloadLoggedInUser();
  }

  void _reloadLoggedInUser() {
    currentUser = _server.getLoggedInUser();
  }
}
