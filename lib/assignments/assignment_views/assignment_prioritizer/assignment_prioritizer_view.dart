import 'package:calendar_v2/assignments/assignment_views/shared/assignment_list_widget/assignment_list_widget.dart';
import 'package:calendar_v2/assignments/assignment_views/assignment_prioritizer/assignment_prioritizer_presenter.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_scaffold/assignment_scaffold.dart';
import 'package:calendar_v2/server/models/assignment.dart';
import 'package:flutter/material.dart';

class AssignmentPrioritizerView extends StatelessWidget {
  final AssignmentPrioritizerPresenter _presenter =
      AssignmentPrioritizerPresenter();

  AssignmentPrioritizerView({super.key});

  @override
  Widget build(BuildContext context) {
    return AssignmentScaffold(
      title: "Prioritizer",
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/assignments/calendar');
          },
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AssignmentListWidget(
          assignmentStream: _presenter.getAssignmentsSortedByPriority(),
        ),
      ),
    );
  }
}
