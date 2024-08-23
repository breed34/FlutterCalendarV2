import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/course_manager/dialogs/add_course_dialog/add_course_dialog_presenter.dart';
import 'package:calendar_v2/assignments/course_manager/dialogs/course_form_widget/course_form_widget.dart';
import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class AddCourseDialog extends StatelessWidget {
  final AddCourseDialogPresenter _presenter = AddCourseDialogPresenter();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final DropdownController<AssignmentColor> _defaultColorController =
      DropdownController<AssignmentColor>();

  AddCourseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Add Course',
      content: Column(
        children: [
          CourseFormWidget(
            formKey: _formKey,
            nameController: _nameController,
            defaultColorController: _defaultColorController,
          ),
          FilledButton(
            onPressed: () {
              _validateFormAndCreateCourse(context);
            },
            child: const Text('Create Course'),
          ),
        ],
      ),
    );
  }

  void _validateFormAndCreateCourse(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.createCourse(
        _nameController.text,
        _defaultColorController.value!,
      );

      Navigator.pop(context);
    }
  }
}
