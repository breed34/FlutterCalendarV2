import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/add_assignment_dialog/add_assignment_dialog_presenter.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/assignment_form_widget/assignment_form_widget.dart';
import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class AddAssignmentDialog extends StatelessWidget {
  late final AddAssignmentDialogPresenter _presenter =
      AddAssignmentDialogPresenter();
  final DateTime? initialDueDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final DropdownController<Course> _courseController =
      DropdownController<Course>();
  late final TextEditingController _dueDateController;
  final DropdownController<AssignmentColor> _colorController =
      DropdownController<AssignmentColor>();
  final TextEditingController _workLeftController = TextEditingController();
  final TextEditingController _percentOfGradeController =
      TextEditingController();

  AddAssignmentDialog({this.initialDueDate, super.key}) {
    _dueDateController = TextEditingController(
      text: _presenter.getDueDateText(initialDueDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Create Assignment',
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
          ),
          FilledButton(
            onPressed: () {
              _validateFormAndCreateAssignment(context);
            },
            child: const Text('Create Assignment'),
          ),
        ],
      ),
    );
  }

  void _validateFormAndCreateAssignment(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.createAssignment(
        _nameController.text,
        _courseController.value!.id,
        _dueDateController.text,
        _colorController.value!,
        _workLeftController.text,
        _percentOfGradeController.text,
      );

      Navigator.pop(context);
    }
  }
}
