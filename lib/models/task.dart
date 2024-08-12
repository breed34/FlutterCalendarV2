class Task {
  final String id;
  final String name;
  final DateTime dueDate;
  final double workRemaining;
  final int importance;

  const Task({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.workRemaining,
    required this.importance,
  });
}
