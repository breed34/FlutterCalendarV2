import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/tasks/calendar_manager_drawer/add_calendar_dialog/add_calendar_dialog.dart';
import 'package:calendar_v2/modules/tasks/calendar_manager_drawer/calendar_manager_drawer_presenter.dart';
import 'package:calendar_v2/modules/tasks/calendar_manager_drawer/edit_calendar_dialog/edit_calendar_dialog.dart';
import 'package:flutter/material.dart';

class CalendarManagerDrawer extends StatelessWidget {
  final CalendarManagerDrawerPresenter _presenter =
      CalendarManagerDrawerPresenter();

  CalendarManagerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Manage Calendars"),
          backgroundColor: Colors.grey[600],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Calendar>>(
                  stream: _presenter.getCalendars(),
                  builder: (context, snapshot) {
                    return ListView(
                      children: _buildCalendarTiles(context, snapshot.data),
                    );
                  },
                ),
              ),
              FilledButton(
                onPressed: () {
                  _openAddCalendarDialog(context);
                },
                style:
                    FilledButton.styleFrom(backgroundColor: Colors.grey[600]),
                child: const Text('Add Calendar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCalendarTiles(
      BuildContext context, List<Calendar>? calendars) {
    if (calendars == null) {
      return [];
    }

    return calendars
        .map(
          (c) => ListTile(
            onTap: () {
              _openEditCalendarDialog(context, c);
            },
            title: Text(c.name),
            leading: Icon(
              Icons.circle,
              color: c.defaultTaskColor.color,
            ),
          ),
        )
        .toList();
  }

  void _openAddCalendarDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => AddCalendarDialog(),
    );
  }

  void _openEditCalendarDialog(BuildContext context, Calendar calendar) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => EditCalendarDialog(
        initialCalendar: calendar,
      ),
    );
  }
}
