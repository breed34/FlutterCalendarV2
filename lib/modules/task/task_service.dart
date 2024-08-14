import 'package:calendar_v2/data/data_handler.dart';
import 'package:calendar_v2/dtos/create_task_request.dart';
import 'package:calendar_v2/dtos/delete_task_request.dart';
import 'package:calendar_v2/dtos/update_task_request.dart';
import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/task.dart';

class TaskService {
  static final TaskService _instance = TaskService._();

  final DataHandler _dataHandler = DataHandler();
  final Set<String> _calendarIdsToHide = {};

  TaskService._();

  factory TaskService() => _instance;

  void showCalendar(String calendarId) {
    _calendarIdsToHide.remove(calendarId);
  }

  void hideCalendar(String calendarId) {
    _calendarIdsToHide.add(calendarId);
  }

  void createTask(CreateTaskRequest request) {
    _dataHandler.createTask(request);
  }

  List<Task> getFilteredTasks() {
    return _dataHandler.getFilteredTasks(_calendarIdsToHide);
  }

  void updateTask(UpdateTaskRequest request) {
    _dataHandler.updateTask(request);
  }

  void deleteTask(DeleteTaskRequest request) {
    _dataHandler.deleteTask(request);
  }

  List<Calendar> getAllCalendars() {
    return _dataHandler.getCalendars();
  }
}
