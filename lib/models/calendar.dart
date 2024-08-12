import 'package:calendar_v2/models/task.dart';

class Calendar {
  final String id;
  final String name;
  final List<Task> tasks;

  const Calendar({
    required this.id,
    required this.name,
    required this.tasks,
  });
}
