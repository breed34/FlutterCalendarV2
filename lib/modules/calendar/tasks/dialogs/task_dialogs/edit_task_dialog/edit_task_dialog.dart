import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_dialogs/edit_task_dialog/edit_task_dialog_presenter.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_dialogs/task_form_widget/task_form_widget.dart';
import 'package:calendar_v2/shared/base_dialog.dart';
import 'package:calendar_v2/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class EditTaskDialog extends StatelessWidget {
  late final EditTaskDialogPresenter _presenter = EditTaskDialogPresenter();
  final Task initialTask;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final DropdownController<Calendar> _calendarController;
  late final TextEditingController _dueDateController;
  late final DropdownController<TaskColor> _colorController;
  late final TextEditingController _workLeftController;
  late final TextEditingController _importanceController;

  EditTaskDialog({required this.initialTask, super.key}) {
    _nameController = TextEditingController(
      text: initialTask.name,
    );

    _calendarController = DropdownController<Calendar>(
      value: _presenter.getCalendarById(initialTask.calendarId),
    );

    _dueDateController = TextEditingController(
      text: _presenter.getDueDateText(initialTask.dueDate),
    );

    _colorController = DropdownController<TaskColor>(
      value: initialTask.color,
    );

    _workLeftController = TextEditingController(
      text: initialTask.workRemaining.toString(),
    );

    _importanceController = TextEditingController(
      text: initialTask.importance.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Update Task',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                onPressed: () {
                  _validateFormAndUpdateTask(context);
                },
                child: const Text('Update Task'),
              ),
              FilledButton(
                onPressed: () {
                  _deleteTask();
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red[600],
                ),
                child: const Text('Delete Task'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _validateFormAndUpdateTask(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.updateTask(
        initialTask.calendarId,
        initialTask.id,
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

  void _deleteTask() {
    _presenter.deleteTask(initialTask.calendarId, initialTask.id);
  }
}
