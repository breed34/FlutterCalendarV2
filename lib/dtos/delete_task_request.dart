class DeleteTaskRequest {
  final String calendarId;
  final String taskId;

  const DeleteTaskRequest({
    required this.calendarId,
    required this.taskId,
  });
}
