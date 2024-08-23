import 'package:calendar_v2/server/models/calendar.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/server/models/task.dart';
import 'package:calendar_v2/tasks/task_views/shared/task_dialogs/edit_task_dialog/edit_task_dialog_presenter.dart';
import 'package:calendar_v2/tasks/task_views/shared/task_dialogs/task_form_widget/task_form_widget.dart';
import 'package:calendar_v2/tasks/shared/base_checkbox_field.dart';
import 'package:calendar_v2/tasks/shared/base_dialog.dart';
import 'package:calendar_v2/tasks/shared/base_dropdown.dart';
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
  late final CheckBoxController _completedController;

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

    _completedController = CheckBoxController(
      value: initialTask.isComplete,
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
            showCompleted: true,
            completedController: _completedController,
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _validateFormAndUpdateTask(context);
                  },
                  child: const Text('Update'),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _deleteTask();
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
        _completedController.value,
      );

      Navigator.pop(context);
    }
  }

  void _deleteTask() {
    _presenter.deleteTask(initialTask.calendarId, initialTask.id);
  }
}
