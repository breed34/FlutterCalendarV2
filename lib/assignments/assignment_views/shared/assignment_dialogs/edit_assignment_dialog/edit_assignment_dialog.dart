import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/edit_assignment_dialog/edit_assignment_dialog_presenter.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/assignment_form_widget/assignment_form_widget.dart';
import 'package:calendar_v2/assignments/shared/base_checkbox_field.dart';
import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class EditAssignmentDialog extends StatelessWidget {
  late final EditAssignmentDialogPresenter _presenter =
      EditAssignmentDialogPresenter();
  final Assignment initialAssignment;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final DropdownController<Course> _courseController;
  late final TextEditingController _dueDateController;
  late final DropdownController<AssignmentColor> _colorController;
  late final TextEditingController _workLeftController;
  late final TextEditingController _percentOfGradeController;
  late final CheckBoxController _completedController;

  EditAssignmentDialog({required this.initialAssignment, super.key}) {
    _nameController = TextEditingController(
      text: initialAssignment.name,
    );

    _dueDateController = TextEditingController(
      text: _presenter.getDueDateText(initialAssignment.dueDate),
    );

    _colorController = DropdownController<AssignmentColor>(
      value: initialAssignment.color,
    );

    _workLeftController = TextEditingController(
      text: initialAssignment.workRemaining.toString(),
    );

    _percentOfGradeController = TextEditingController(
      text: initialAssignment.percentOfGrade.toString(),
    );

    _completedController = CheckBoxController(
      value: initialAssignment.isComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    _courseController = DropdownController<Course>(
      value: _presenter.getCourseById(initialAssignment.courseId),
    );

    return BaseDialog(
      title: 'Update Assignment',
      content: Column(
        children: [
          AssignmentFormWidget(
            formKey: _formKey,
            nameController: _nameController,
            courseController: _courseController,
            dueDateController: _dueDateController,
            colorController: _colorController,
            workLeftController: _workLeftController,
            percentOfGradeController: _percentOfGradeController,
            showCompleted: true,
            completedController: _completedController,
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _validateFormAndUpdateAssignment(context);
                  },
                  child: const Text('Update'),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _deleteAssignment();
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red[600],
                  ),
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _validateFormAndUpdateAssignment(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.updateAssignment(
        initialAssignment.courseId,
        initialAssignment.id,
        _nameController.text,
        _courseController.value!.id,
        _dueDateController.text,
        _colorController.value!,
        _workLeftController.text,
        _percentOfGradeController.text,
        _completedController.value,
      );

      Navigator.pop(context);
    }
  }

  void _deleteAssignment() {
    _presenter.deleteAssignment(
        initialAssignment.courseId, initialAssignment.id);
  }
}
