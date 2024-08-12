import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/models/user.dart';

var exampleUser = User(
  id: "123",
  username: "User123",
  calendars: [
    Calendar(
      id: "asd",
      name: "Calendar 1",
      tasks: [
        Task(
          id: "a1",
          name: "Task 1",
          dueDate: DateTime.parse("2024-08-20"),
          workRemaining: 12.0,
          importance: 4,
        ),
        Task(
          id: "a2",
          name: "Task 2",
          dueDate: DateTime.parse("2024-08-23"),
          workRemaining: 6.0,
          importance: 2,
        ),
      ],
    ),
  ],
);

class Server {
  User loginUser() {
    return exampleUser;
  }

  User registerUser() {
    return exampleUser;
  }

  void logoutUser() {}
}
