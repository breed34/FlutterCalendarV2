class UpdateCalendarRequest {
  final String calendarId;
  final String? name;

  const UpdateCalendarRequest({
    required this.calendarId,
    this.name,
  });
}
