class CreateTaskRequest {
  final String calendarId;
  final String name;
  final DateTime dueDate;
  final double workRemaining;
  final double percentOfGrade;

  const CreateTaskRequest({
    required this.calendarId,
    required this.name,
    required this.dueDate,
    required this.workRemaining,
    required this.percentOfGrade,
  });
}
