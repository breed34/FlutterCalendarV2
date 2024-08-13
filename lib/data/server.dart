import 'package:calendar_v2/dtos/create_calendar_request.dart';
import 'package:calendar_v2/dtos/create_task_request.dart';
import 'package:calendar_v2/dtos/delete_calendar_request.dart';
import 'package:calendar_v2/dtos/delete_task_request.dart';
import 'package:calendar_v2/dtos/update_calendar_request.dart';
import 'package:calendar_v2/dtos/update_task_request.dart';
import 'package:calendar_v2/enums.dart';
import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/models/user.dart';
import 'package:uuid/uuid.dart';

class Server {
  final Uuid _uuid = const Uuid();
  late final User _exampleUser;

  Server() {
    _exampleUser = User(
      id: _uuid.v4(),
      username: "User123",
      calendars: [
        Calendar(
          id: _uuid.v4(),
          name: "Calendar 1",
          defaultTaskColor: TaskColor.blue,
          tasks: [
            Task(
              id: _uuid.v4(),
              name: "Task 1",
              color: TaskColor.green,
              dueDate: DateTime.parse("2024-08-20"),
              workRemaining: 12.0,
              percentOfGrade: 4,
            ),
            Task(
              id: _uuid.v4(),
              name: "Task 2",
              color: TaskColor.red,
              dueDate: DateTime.parse("2024-08-23"),
              workRemaining: 6.0,
              percentOfGrade: 2,
            ),
          ],
        ),
      ],
    );
  }

  // User Operations
  User loginUser() {
    return _exampleUser;
  }

  User registerUser() {
    return _exampleUser;
  }

  void logoutUser() {}

  User getLoggedInUser() {
    return _exampleUser;
  }

  // Calendar Operations
  void createCalendar(CreateCalendarRequest request) {
    var calendar = Calendar(
      id: _uuid.v4(),
      name: request.name,
      defaultTaskColor: request.defaultTaskColor,
      tasks: [],
    );

    _exampleUser.calendars.add(calendar);
  }

  void updateCalendar(UpdateCalendarRequest request) {
    var existingCalendarIndex =
        _exampleUser.calendars.indexWhere((c) => c.id == request.calendarId);
    var existingCalendar = _exampleUser.calendars[existingCalendarIndex];

    var newCalendar = Calendar(
      id: existingCalendar.id,
      name: request.name ?? existingCalendar.name,
      defaultTaskColor:
          request.defaultTaskColor ?? existingCalendar.defaultTaskColor,
      tasks: existingCalendar.tasks,
    );

    _exampleUser.calendars[existingCalendarIndex] = newCalendar;
  }

  void deleteCalendar(DeleteCalendarRequest request) {
    _exampleUser.calendars.removeWhere((c) => c.id == request.calendarId);
  }

  // Task Operations
  void createTask(CreateTaskRequest request) {
    var calendar =
        _exampleUser.calendars.firstWhere((c) => c.id == request.calendarId);
    var task = Task(
      id: _uuid.v4(),
      name: request.name,
      color: request.color,
      dueDate: request.dueDate,
      workRemaining: request.workRemaining,
      percentOfGrade: request.percentOfGrade,
    );

    calendar.tasks.add(task);
  }

  void updateTask(UpdateTaskRequest request) {
    var calendar =
        _exampleUser.calendars.firstWhere((c) => c.id == request.calendarId);
    var existingTaskIndex =
        calendar.tasks.indexWhere((t) => t.id == request.taskId);
    var existingTask = calendar.tasks[existingTaskIndex];

    var newTask = Task(
      id: existingTask.id,
      name: request.name ?? existingTask.name,
      color: request.color ?? existingTask.color,
      dueDate: request.dueDate ?? existingTask.dueDate,
      workRemaining: request.workRemaining ?? existingTask.workRemaining,
      percentOfGrade: request.percentOfGrade ?? existingTask.percentOfGrade,
    );

    calendar.tasks[existingTaskIndex] = newTask;
  }

  void deleteTask(DeleteTaskRequest request) {
    var calendar =
        _exampleUser.calendars.firstWhere((c) => c.id == request.calendarId);

    calendar.tasks.removeWhere((t) => t.id == request.taskId);
  }
}
