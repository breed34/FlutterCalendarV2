import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/server/models/task.dart';

class Calendar {
  final String id;
  String name;
  TaskColor defaultTaskColor;
  List<Task> tasks;

  Calendar({
    required this.id,
    required this.name,
    required this.defaultTaskColor,
    required this.tasks,
  });
}
