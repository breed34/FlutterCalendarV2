class UpdateTaskRequest {
  final String calendarId;
  final String taskId;
  final String? name;
  final DateTime? dueDate;
  final double? workRemaining;
  final double? percentOfGrade;

  const UpdateTaskRequest({
    required this.calendarId,
    required this.taskId,
    this.name,
    this.dueDate,
    this.workRemaining,
    this.percentOfGrade,
  });
}
