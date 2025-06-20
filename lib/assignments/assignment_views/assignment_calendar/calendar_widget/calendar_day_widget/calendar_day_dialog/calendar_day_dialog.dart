import 'package:calendar_v2/assignments/assignment_views/assignment_calendar/calendar_widget/calendar_day_widget/calendar_day_dialog/calendar_day_dialog_presenter.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_list_widget/assignment_list_widget.dart';
import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:flutter/material.dart';

class CalendarDayDialog extends StatelessWidget {
  late final CalendarDayDialogPresenter _presenter;
  final DateTime day;

  CalendarDayDialog(this.day, {super.key}) {
    _presenter = CalendarDayDialogPresenter(day);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: _presenter.getFormattedDate(),
      content: Expanded(
        child: AssignmentListWidget(
          assignmentStream: _presenter.getAssignments(),
          initialDueDate: day,
        ),
      ),
    );
  }
}
