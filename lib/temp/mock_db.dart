import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:uuid/uuid.dart';

class MockDB {
  static final MockDB _instance = MockDB._();
  final Uuid _uuid = const Uuid();
  late final Map<String, List<Calendar>> entries;

  MockDB._() {
    entries = {
      'abc': [
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
              importance: 4,
            ),
            Task(
              id: _uuid.v4(),
              name: "Task 2",
              color: TaskColor.red,
              dueDate: DateTime.parse("2024-08-23"),
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
