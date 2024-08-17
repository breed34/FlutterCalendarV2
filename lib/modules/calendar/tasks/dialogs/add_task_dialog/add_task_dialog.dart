import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/add_task_dialog/add_task_dialog_presenter.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/add_task_dialog/calendar_dropdown_widget/calendar_dropdown_widget.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/add_task_dialog/color_dropdown_widget/color_dropdown_widget.dart';
import 'package:calendar_v2/shared/base_dialog.dart';
import 'package:calendar_v2/shared/base_input.dart';
import 'package:calendar_v2/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class AddTaskDialog extends StatefulWidget {
  final DateTime? initialDueDate;

  const AddTaskDialog({this.initialDueDate, super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late final AddTaskDialogPresenter _presenter;
  final double _fieldSpacing = 12.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final DropdownController<Calendar> _calendarController =
      DropdownController<Calendar>();
  late final TextEditingController _dueDateController;
  final DropdownController<TaskColor> _colorController =
      DropdownController<TaskColor>();
  final TextEditingController _workLeftController = TextEditingController();
  final TextEditingController _importanceController = TextEditingController();

  @override
  void initState() {
    _presenter = AddTaskDialogPresenter(initialDueDate: widget.initialDueDate);
    _dueDateController = TextEditingController(
      text: _presenter.getInitialDueDateValue(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Create Task',
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            BaseInput(
              label: "Name",
              required: true,
              controller: _nameController,
            ),
            SizedBox(height: _fieldSpacing),
            CalendarDropdownWidget(
              label: 'Calendar',
              controller: _calendarController,
              required: true,
            ),
            SizedBox(height: _fieldSpacing),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: BaseInput(
                    label: "Due Date",
                    type: BaseInputType.datetime,
                    required: true,
                    controller: _dueDateController,
                  ),
                ),
                SizedBox(width: _fieldSpacing),
                Flexible(
                  flex: 1,
                  child: ColorDropdownWidget(
                    label: "Color",
                    controller: _colorController,
                    required: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: _fieldSpacing),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: BaseInput(
                    label: "Work Left",
                    type: BaseInputType.decimal,
                    required: true,
                    controller: _workLeftController,
                  ),
                ),
                SizedBox(width: _fieldSpacing),
                Flexible(
                  flex: 1,
                  child: BaseInput(
                    label: "Importance",
                    type: BaseInputType.decimal,
                    required: true,
                    controller: _importanceController,
                  ),
                ),
              ],
            ),
            SizedBox(height: _fieldSpacing),
            FilledButton(
              onPressed: () {
                _validateFormAndCreateTask();
                Navigator.pop(context);
              },
              child: const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _validateFormAndCreateTask() {
    if (_formKey.currentState!.validate()) {
      _presenter.createTask(
        _nameController.text,
        _calendarController.value!.id,
        _dueDateController.text,
        _colorController.value!,
        _workLeftController.text,
        _importanceController.text,
      );
    }
  }
}
