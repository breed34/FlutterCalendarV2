import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/models/user.dart';
import 'package:calendar_v2/data/server.dart';

class DataHandler {
  static final DataHandler _instance = DataHandler._();

  final Server _server = Server();
  late User? currentUser;

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
  void createCalendar() {}

  List<Calendar> getCalendars() {
    return currentUser!.calendars;
  }

  void updateCalendar() {}

  void deleteCalendar() {}

  // Task Operations
  void createTask() {}

  List<Task> getFilteredTasks() {
    return currentUser!.calendars.expand((c) => c.tasks).toList();
  }

  void updateTask() {}

  void deleteTask() {}
}
