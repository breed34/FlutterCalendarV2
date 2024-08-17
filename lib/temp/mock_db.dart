import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:uuid/uuid.dart';

class MockDB {
  static final MockDB _instance = MockDB._();
  final Uuid _uuid = const Uuid();
  late final Map<String, List<Calendar>> entries;

  MockDB._() {
    String calendar1Id = _uuid.v4();
    String calendar2Id = _uuid.v4();

    entries = {
      'abc': [
        Calendar(
          id: calendar1Id,
          name: "Calendar 1",
          defaultTaskColor: TaskColor.blue,
          tasks: [
            Task(
              id: _uuid.v4(),
              calendarId: calendar1Id,
              name: "Task 1",
              color: TaskColor.green,
              dueDate: DateTime.parse("2024-08-20"),
              workRemaining: 12.0,
              importance: 4,
            ),
            Task(
              id: _uuid.v4(),
              calendarId: calendar1Id,
              name: "Task 2",
              color: TaskColor.red,
              dueDate: DateTime.parse("2024-08-23"),
              workRemaining: 6.0,
              importance: 2,
            ),
          ],
        ),
        Calendar(
          id: calendar2Id,
          name: "Calendar 2",
          defaultTaskColor: TaskColor.blue,
          tasks: [
            Task(
              id: _uuid.v4(),
              calendarId: calendar2Id,
              name: "Task 3",
              color: TaskColor.green,
              dueDate: DateTime.parse("2024-08-21"),
              workRemaining: 12.0,
              importance: 4,
            ),
            Task(
              id: _uuid.v4(),
              calendarId: calendar2Id,
              name: "Task 4",
              color: TaskColor.red,
              dueDate: DateTime.parse("2024-08-24"),
              workRemaining: 6.0,
              importance: 2,
            ),
          ],
        ),
      ]
    };
  }

  factory MockDB() => _instance;
}
