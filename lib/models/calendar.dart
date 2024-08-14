import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/models/task.dart';

class Calendar {
  final String id;
  final String name;
  final TaskColor defaultTaskColor;
  final List<Task> tasks;

  const Calendar({
    required this.id,
    required this.name,
    required this.defaultTaskColor,
    required this.tasks,
  });
}
