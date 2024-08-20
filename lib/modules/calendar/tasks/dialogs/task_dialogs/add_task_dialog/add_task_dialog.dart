import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_dialogs/add_task_dialog/add_task_dialog_presenter.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_dialogs/task_form_widget/task_form_widget.dart';
import 'package:calendar_v2/shared/base_dialog.dart';
import 'package:calendar_v2/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  late final AddTaskDialogPresenter _presenter = AddTaskDialogPresenter();
  final DateTime? initialDueDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final DropdownController<Calendar> _calendarController =
      DropdownController<Calendar>();
  late final TextEditingController _dueDateController;
  final DropdownController<TaskColor> _colorController =
      DropdownController<TaskColor>();
  final TextEditingController _workLeftController = TextEditingController();
  final TextEditingController _importanceController = TextEditingController();

  AddTaskDialog({this.initialDueDate, super.key}) {
    _dueDateController = TextEditingController(
      text: _presenter.getDueDateText(initialDueDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Create Task',
      content: Column(
        children: [
          TaskFormWidget(
            formKey: _formKey,
            nameController: _nameController,
            calendarController: _calendarController,
            dueDateController: _dueDateController,
            colorController: _colorController,
            workLeftController: _workLeftController,
            importanceController: _importanceController,
          ),
          FilledButton(
            onPressed: () {
              _validateFormAndCreateTask(context);
            },
            child: const Text('Create Task'),
          ),
        ],
      ),
    );
  }

  void _validateFormAndCreateTask(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.createTask(
        _nameController.text,
        _calendarController.value!.id,
        _dueDateController.text,
        _colorController.value!,
        _workLeftController.text,
        _importanceController.text,
      );

      Navigator.pop(context);
    }
  }
}
