import 'package:calendar_v2/server/models/calendar.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/tasks/calendar_manager/dialogs/calendar_form_widget/calendar_form_widget.dart';
import 'package:calendar_v2/tasks/calendar_manager/dialogs/edit_calendar_dialog/edit_calendar_dialog_presenter.dart';
import 'package:calendar_v2/tasks/shared/base_dialog.dart';
import 'package:calendar_v2/tasks/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class EditCalendarDialog extends StatelessWidget {
  final EditCalendarDialogPresenter _presenter = EditCalendarDialogPresenter();
  final Calendar initialCalendar;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final DropdownController<TaskColor> _defaultColorController;

  EditCalendarDialog({
    required this.initialCalendar,
    super.key,
  }) {
    _nameController = TextEditingController(
      text: initialCalendar.name,
    );

    _defaultColorController = DropdownController<TaskColor>(
      value: initialCalendar.defaultTaskColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Edit Calendar',
      content: Column(
        children: [
          CalendarFormWidget(
            formKey: _formKey,
            nameController: _nameController,
            defaultColorController: _defaultColorController,
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _validateFormAndUpdateCalendar(context);
                  },
                  child: const Text('Update'),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _deleteCalendar();
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

  void _validateFormAndUpdateCalendar(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.updateCalendar(
        initialCalendar.id,
        _nameController.text,
        _defaultColorController.value!,
      );

      Navigator.pop(context);
    }
  }

  void _deleteCalendar() {
    _presenter.deleteCalendar(initialCalendar.id);
  }
}
