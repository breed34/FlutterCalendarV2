import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/tasks/calendar_manager_drawer/add_calendar_dialog/add_calendar_dialog_presenter.dart';
import 'package:calendar_v2/tasks/calendar_manager_drawer/calendar_form_widget/calendar_form_widget.dart';
import 'package:calendar_v2/tasks/shared/base_dialog.dart';
import 'package:calendar_v2/tasks/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class AddCalendarDialog extends StatelessWidget {
  final AddCalendarDialogPresenter _presenter = AddCalendarDialogPresenter();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final DropdownController<TaskColor> _defaultColorController =
      DropdownController<TaskColor>();

  AddCalendarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Add Calendar',
      content: Column(
        children: [
          CalendarFormWidget(
            formKey: _formKey,
            nameController: _nameController,
            defaultColorController: _defaultColorController,
          ),
          FilledButton(
            onPressed: () {
              _validateFormAndCreateCalendar(context);
            },
            child: const Text('Create Calendar'),
          ),
        ],
      ),
    );
  }

  void _validateFormAndCreateCalendar(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.createCalendar(
        _nameController.text,
        _defaultColorController.value!,
      );

      Navigator.pop(context);
    }
  }
}
