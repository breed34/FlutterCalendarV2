import 'package:calendar_v2/modules/calendar/tasks/dialogs/filter_calendars_dialog/filter_calendars_dialog.dart';
import 'package:flutter/material.dart';

class TaskScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const TaskScaffold({
    required this.title,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _openFilterCalendarsDialog(context);
              },
              icon: const Icon(Icons.filter_alt),
            ),
            const SizedBox(width: 8.0)
          ],
        ),
        body: body);
  }

  void _openFilterCalendarsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => FilterCalendarsDialog(),
    );
  }
}
