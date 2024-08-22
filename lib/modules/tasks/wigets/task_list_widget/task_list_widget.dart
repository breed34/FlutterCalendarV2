import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/modules/tasks/dialogs/task_dialogs/add_task_dialog/add_task_dialog.dart';
import 'package:calendar_v2/modules/tasks/dialogs/task_dialogs/edit_task_dialog/edit_task_dialog.dart';
import 'package:calendar_v2/modules/tasks/wigets/task_widget/task_widget.dart';
import 'package:flutter/material.dart';

class TaskListWidget extends StatelessWidget {
  final Stream<List<Task>>? taskStream;
  final DateTime? initialDueDate;

  const TaskListWidget({
    required this.taskStream,
    this.initialDueDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: taskStream,
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: _buildTaskWidgets(context, snapshot.data),
              ),
            ),
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
    );
  }

  List<Widget> _buildTaskWidgets(BuildContext context, List<Task>? tasks) {
    if (tasks != null && tasks.isNotEmpty) {
      return tasks.map((task) {
        return GestureDetector(
          onTap: () {
            _openEditTaskDialog(context, task);
          },
          child: TaskWidget(
            task,
            scale: 1.5,
          ),
        );
      }).toList();
    }

    return [
      const SizedBox(height: 96.0),
      const Center(child: Text('No tasks')),
    ];
  }

  void _openAddTaskDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) =>
          AddTaskDialog(initialDueDate: initialDueDate),
    );
  }

  void _openEditTaskDialog(BuildContext context, Task task) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => EditTaskDialog(initialTask: task),
    );
  }
}
