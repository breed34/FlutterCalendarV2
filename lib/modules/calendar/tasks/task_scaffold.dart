import 'package:calendar_v2/modules/calendar/calendar_scaffold.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/filter_calendars_dialog/filter_calendars_dialog.dart';
import 'package:flutter/material.dart';

class TaskScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const TaskScaffold({
    required this.title,
    required this.body,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CalendarScaffold(
      title: title,
      body: body,
      actions: [
        ...(actions ?? []),
        const SizedBox(width: 8.0),
        IconButton(
          onPressed: () {
            _openFilterCalendarsDialog(context);
          },
          icon: const Icon(Icons.filter_alt_outlined),
        ),
        const SizedBox(width: 8.0)
      ],
    );
  }

  void _openFilterCalendarsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => const FilterCalendarsDialog(),
    );
  }
}
