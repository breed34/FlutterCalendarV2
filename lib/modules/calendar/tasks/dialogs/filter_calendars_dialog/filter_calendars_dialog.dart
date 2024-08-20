import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/filter_calendars_dialog/filter_calendars_dialog_presenter.dart';
import 'package:calendar_v2/shared/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FilterCalendarsDialog extends StatefulWidget {
  const FilterCalendarsDialog({super.key});

  @override
  State<FilterCalendarsDialog> createState() => _FilterCalendarsDialogState();
}

class _FilterCalendarsDialogState extends State<FilterCalendarsDialog> {
  final FilterCalendarsDialogPresenter _presenter =
      FilterCalendarsDialogPresenter();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Filter Calendars',
      content: StreamBuilder(
        stream: _presenter.getFilterCalendars(),
        builder: (context, snapshot) => Column(
          children: _buildListChildren(snapshot.data),
        ),
      ),
    );
  }

  List<Widget> _buildListChildren(List<FilterCalendar>? calendars) {
    if (calendars == null) {
      return [];
    }

    return calendars
        .map((c) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(c.calendar.name),
                  Checkbox(
                    activeColor: c.calendar.defaultTaskColor.color,
                    value: c.show,
                    onChanged: (value) {
                      c.show = value!;
                      _presenter.hideShowCalendar(c);
                    },
                  ),
                ],
              ),
            ))
        .toList();
  }
}
