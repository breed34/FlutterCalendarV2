import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_dialogs/add_task_dialog/add_task_dialog.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_dialogs/edit_task_dialog/edit_task_dialog.dart';
import 'package:calendar_v2/modules/calendar/tasks/task_calendar/calendar_widget/calendar_day_widget/calendar_day_dialog/calendar_day_dialog_presenter.dart';
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
      content: StreamBuilder<List<Task>>(
        stream: _presenter.getTasks(),
        builder: (context, snapshot) {
          return Column(
            children: [
              ..._buildTaskWidgets(context, snapshot.data),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  _openAddTaskDialog(context);
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text('Add Task'),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildTaskWidgets(BuildContext context, List<Task>? tasks) {
    if (tasks != null && tasks.isNotEmpty) {
      return tasks.map((task) {
        return GestureDetector(
          onTap: () {
            _openEditTaskDialog(context, task);
          },
          child: SizedBox(
            width: double.infinity,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
          ),
        );
      }).toList();
    }

    return [
      const Text('No tasks'),
    ];
  }

  void _openAddTaskDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) =>
          AddTaskDialog(initialDueDate: day),
    );
  }

  void _openEditTaskDialog(BuildContext context, Task task) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => EditTaskDialog(initialTask: task),
    );
  }
}
