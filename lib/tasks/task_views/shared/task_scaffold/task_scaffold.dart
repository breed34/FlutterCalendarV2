import 'package:calendar_v2/tasks/calendar_manager/calendar_manager_view.dart';
import 'package:calendar_v2/tasks/task_views/shared/filter_calendars_dialog/filter_calendars_dialog.dart';
import 'package:calendar_v2/tasks/task_views/shared/task_scaffold/nav_drawer_widget/nav_drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        automaticallyImplyLeading: false,
        actions: [
          ...(widget.actions ?? []),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {
              _openFilterCalendarsDialog(context);
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: widget.body,
      endDrawer: const NavDrawerWidget(),
    );
  }

  void _openFilterCalendarsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => const FilterCalendarsDialog(),
    );
  }
}
