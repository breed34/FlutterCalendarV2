import 'package:calendar_v2/modules/calendar/tasks/task_calendar/calendar_widget/calendar_day_widget/calendar_day_dialog/calendar_day_dialog_presenter.dart';
import 'package:calendar_v2/modules/calendar/tasks/wigets/task_list_widget/task_list_widget.dart';
import 'package:calendar_v2/shared/base_dialog.dart';
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
      content: SizedBox(
        width: double.maxFinite,
        height: 300.0,
        child: TaskListWidget(
          taskStream: _presenter.getTasks(),
          initialDueDate: day,
        ),
      ),
    );
  }
}
