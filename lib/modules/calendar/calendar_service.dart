import 'package:calendar_v2/dtos/create_calendar_request.dart';
import 'package:calendar_v2/dtos/delete_calendar_request.dart';
import 'package:calendar_v2/dtos/update_calendar_request.dart';
import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/server.dart';
import 'package:calendar_v2/temp/mock_user_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class CalendarService {
  static final CalendarService _instance = CalendarService._();

  final MockUserService _userService = MockUserService();
  final Server _server = Server();
  final Uuid _uuid = const Uuid();
  final BehaviorSubject<List<String>> _calendarIdsToHide =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Calendar>> _calendars =
      BehaviorSubject<List<Calendar>>();

  CalendarService._();

  factory CalendarService() => _instance;

  void createTask(
    String calendarId,
    String name,
    TaskColor color,
    DateTime dueDate,
    double workRemaining,
    double importance,
  ) {
    List<Calendar> calendars = List.from(_calendars.value);
    Calendar calendarToUpdate = calendars.firstWhere((c) => c.id == calendarId);

    calendarToUpdate.tasks.add(Task(
      id: _uuid.v4(),
      calendarId: calendarToUpdate.id,
      name: name,
      color: color,
      dueDate: dueDate,
      workRemaining: workRemaining,
      importance: importance,
      isComplete: false,
    ));

    _calendars.sink.add(calendars);
    _server.updateCalendar(UpdateCalendarRequest(
      userId: _userService.getUserId(),
      calendarId: calendarToUpdate.id,
      tasks: calendarToUpdate.tasks,
    ));
  }

  Stream<List<Task>> getFilteredTasks() {
    if (!_calendars.hasValue) {
      _calendars.sink.add(_server.getCalendars(_userService.getUserId()));
    }

    return getFilteredCalendars()
        .map((cs) => cs.expand((c) => c.tasks).toList());
  }

  void updateTask(
    String currentCalendarId,
    String taskId,
    String? newCalendarId,
    String? name,
    TaskColor? color,
    DateTime? dueDate,
    double? workRemaining,
    double? importance,
    bool? isComplete,
  ) {
    List<Calendar> calendars = List.from(_calendars.value);
    Calendar currentCalendarToUpdate =
        calendars.firstWhere((c) => c.id == currentCalendarId);

    Task taskToUpdate =
        currentCalendarToUpdate.tasks.firstWhere((t) => t.id == taskId);

    taskToUpdate.name = name ?? taskToUpdate.name;
    taskToUpdate.color = color ?? taskToUpdate.color;
    taskToUpdate.dueDate = dueDate ?? taskToUpdate.dueDate;
    taskToUpdate.workRemaining = workRemaining ?? taskToUpdate.workRemaining;
    taskToUpdate.importance = importance ?? taskToUpdate.importance;
    taskToUpdate.isComplete = isComplete ?? taskToUpdate.isComplete;

    if (newCalendarId != null && currentCalendarId != newCalendarId) {
      Calendar newCalendarToUpdate =
          calendars.firstWhere((c) => c.id == newCalendarId);
      taskToUpdate.calendarId = newCalendarToUpdate.id;
      currentCalendarToUpdate.tasks.removeWhere((t) => t.id == taskToUpdate.id);
      newCalendarToUpdate.tasks.add(taskToUpdate);

      _server.updateCalendar(UpdateCalendarRequest(
        userId: _userService.getUserId(),
        calendarId: newCalendarToUpdate.id,
        tasks: newCalendarToUpdate.tasks,
      ));
    }

    _calendars.sink.add(calendars);
    _server.updateCalendar(UpdateCalendarRequest(
      userId: _userService.getUserId(),
      calendarId: currentCalendarToUpdate.id,
      tasks: currentCalendarToUpdate.tasks,
    ));
  }

  void deleteTask(String calendarId, String taskId) {
    List<Calendar> calendars = List.from(_calendars.value);
    Calendar calendarToUpdate = calendars.firstWhere((c) => c.id == calendarId);

    calendarToUpdate.tasks.removeWhere((t) => t.id == taskId);

    _calendars.sink.add(calendars);
    _server.updateCalendar(UpdateCalendarRequest(
      userId: _userService.getUserId(),
      calendarId: calendarToUpdate.id,
      tasks: calendarToUpdate.tasks,
    ));
  }

  void createCalendar(String name, TaskColor defaultTaskColor) {
    List<Calendar> calendars = List.from(_calendars.value);
    calendars.add(Calendar(
      id: _uuid.v4(),
      name: name,
      defaultTaskColor: defaultTaskColor,
      tasks: [],
    ));

    _calendars.sink.add(calendars);
    _server.createCalendar(CreateCalendarRequest(
      userId: _userService.getUserId(),
      name: name,
      defaultTaskColor: defaultTaskColor,
    ));
  }

  Calendar getCalendarById(String calendarId) {
    if (!_calendars.hasValue) {
      _calendars.sink.add(_server.getCalendars(_userService.getUserId()));
    }

    return _calendars.value.firstWhere((c) => c.id == calendarId);
  }

  Stream<List<Calendar>> getCalendars() {
    if (!_calendars.hasValue) {
      _calendars.sink.add(_server.getCalendars(_userService.getUserId()));
    }

    return _calendars.stream;
  }

  Stream<List<Calendar>> getFilteredCalendars() {
    if (!_calendars.hasValue) {
      _calendars.sink.add(_server.getCalendars(_userService.getUserId()));
    }

    return Rx.combineLatest2(_calendars.stream, _calendarIdsToHide,
        (cs, cids) => cs.where((c) => !cids.contains(c.id)).toList());
  }

  void updateCalendar(
    String calendarId,
    String? name,
    TaskColor? defaultTaskColor,
  ) {
    List<Calendar> calendars = List.from(_calendars.value);
    Calendar calendarToUpdate = calendars.firstWhere((c) => c.id == calendarId);

    calendarToUpdate.name = name ?? calendarToUpdate.name;
    calendarToUpdate.defaultTaskColor =
        defaultTaskColor ?? calendarToUpdate.defaultTaskColor;

    _calendars.sink.add(calendars);
    _server.updateCalendar(UpdateCalendarRequest(
      userId: _userService.getUserId(),
      calendarId: calendarId,
      name: calendarToUpdate.name,
      defaultTaskColor: calendarToUpdate.defaultTaskColor,
    ));
  }

  void hideCalendar(String calendarId) {
    var calendarIds = _calendarIdsToHide.value;
    calendarIds.add(calendarId);
    _calendarIdsToHide.sink.add(calendarIds);
  }

  void showCalendar(String calendarId) {
    var calendarIds = _calendarIdsToHide.value;
    calendarIds.remove(calendarId);
    _calendarIdsToHide.sink.add(calendarIds);
  }

  void deleteCalendar(String calendarId) {
    List<Calendar> calendars = List.from(_calendars.value);
    calendars.removeWhere((c) => c.id == calendarId);

    _calendars.sink.add(calendars);
    _server.deleteCalendar(DeleteCalendarRequest(
      userId: _userService.getUserId(),
      calendarId: calendarId,
    ));
  }
}
