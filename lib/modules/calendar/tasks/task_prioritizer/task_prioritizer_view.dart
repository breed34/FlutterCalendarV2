import 'package:calendar_v2/modules/calendar/tasks/wigets/task_list_widget/task_list_widget.dart';
import 'package:calendar_v2/modules/calendar/tasks/task_prioritizer/task_prioritizer_presenter.dart';
import 'package:calendar_v2/modules/calendar/tasks/task_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskPrioritizerView extends StatelessWidget {
  final TaskPrioritizerPresenter _presenter = TaskPrioritizerPresenter();

  TaskPrioritizerView({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskScaffold(
      title: "Prioritizer",
      actions: [
        IconButton(
          onPressed: () {
            context.go('/tasks/calendar');
          },
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TaskListWidget(
              taskStream: _presenter.getTasksSortedByPriority(),
            ),
          ),
        ],
      ),
    );
  }
}
