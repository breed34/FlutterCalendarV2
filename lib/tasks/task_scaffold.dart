import 'package:calendar_v2/tasks/calendar_manager_drawer/calendar_manager_drawer.dart';
import 'package:calendar_v2/tasks/shared/dialogs/filter_calendars_dialog/filter_calendars_dialog.dart';
import 'package:flutter/material.dart';

class TaskScaffold extends StatefulWidget {
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
  State<TaskScaffold> createState() => _TaskScaffoldState();
}

class _TaskScaffoldState extends State<TaskScaffold> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: _openDrawer,
          icon: const Icon(Icons.edit_calendar_outlined),
        ),
        actions: [
          ...(widget.actions ?? []),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {
              _openFilterCalendarsDialog(context);
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
          const SizedBox(width: 8.0)
        ],
      ),
      body: widget.body,
      drawer: CalendarManagerDrawer(),
    );
  }

  void _openFilterCalendarsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => const FilterCalendarsDialog(),
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}
