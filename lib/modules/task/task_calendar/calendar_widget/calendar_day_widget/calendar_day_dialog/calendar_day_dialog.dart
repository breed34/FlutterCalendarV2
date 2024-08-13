import 'package:calendar_v2/modules/task/task_calendar/calendar_widget/calendar_day_widget/calendar_day_dialog/calendar_day_dialog_presenter.dart';
import 'package:calendar_v2/shared/base_dialog.dart';
import 'package:flutter/material.dart';

class CalendarDayDialog extends StatelessWidget {
  late final CalendarDayDialogPresenter _presenter;

  CalendarDayDialog(DateTime day, {super.key}) {
    _presenter = CalendarDayDialogPresenter(day);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: _presenter.getFormattedDate(),
      content: Column(
        children: [
          ..._buildTaskWidgets(),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              _openAddTaskDialog(context);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.grey),
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTaskWidgets() {
    var tasks = _presenter.getTasks();
    if (tasks.isNotEmpty) {
      return tasks.map((task) {
        return SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            margin: const EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              color: task.color.color,
            ),
            child: Text(
              task.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      }).toList();
    }

    return [
      const Text('No tasks'),
    ];
  }

  void _openAddTaskDialog(context) async {
    // await showDialog(
    //   context: context,
    //   builder: (BuildContext buildContext) => const AddTask(),
    // );
  }
}
