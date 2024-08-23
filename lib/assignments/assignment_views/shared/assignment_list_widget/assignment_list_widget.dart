import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/add_assignment_dialog/add_assignment_dialog.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/edit_assignment_dialog/edit_assignment_dialog.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_widget/assignment_widget.dart';
import 'package:flutter/material.dart';

class AssignmentListWidget extends StatelessWidget {
  final Stream<List<Assignment>>? assignmentStream;
  final DateTime? initialDueDate;

  const AssignmentListWidget({
    required this.assignmentStream,
    this.initialDueDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Assignment>>(
      stream: assignmentStream,
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: _buildAssignmentWidgets(context, snapshot.data),
              ),
            ),
            FilledButton(
              onPressed: () {
                _openAddAssignmentDialog(context);
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Add Assignment'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildAssignmentWidgets(
      BuildContext context, List<Assignment>? assignments) {
    if (assignments != null && assignments.isNotEmpty) {
      return assignments.map((assignment) {
        return GestureDetector(
          onTap: () {
            _openEditAssignmentDialog(context, assignment);
          },
          child: AssignmentWidget(
            assignment,
            scale: 1.5,
          ),
        );
      }).toList();
    }

    return [
      const SizedBox(height: 96.0),
      const Center(child: Text('No assignments')),
    ];
  }

  void _openAddAssignmentDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) =>
          AddAssignmentDialog(initialDueDate: initialDueDate),
    );
  }

  void _openEditAssignmentDialog(
      BuildContext context, Assignment assignment) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) =>
          EditAssignmentDialog(initialAssignment: assignment),
    );
  }
}
