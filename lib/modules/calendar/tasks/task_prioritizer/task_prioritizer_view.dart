import 'package:calendar_v2/modules/calendar/tasks/task_prioritizer/task_prioritizer_presenter.dart';
import 'package:flutter/material.dart';

class TaskPrioritizerView extends StatelessWidget {
  final TaskPrioritizerPresenter _presenter = TaskPrioritizerPresenter();

  TaskPrioritizerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prioritizer")),
      body: const Placeholder(),
    );
  }
}
