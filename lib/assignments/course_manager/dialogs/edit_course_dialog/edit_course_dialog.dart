import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/course_manager/dialogs/course_form_widget/course_form_widget.dart';
import 'package:calendar_v2/assignments/course_manager/dialogs/edit_course_dialog/edit_course_dialog_presenter.dart';
import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class EditCourseDialog extends StatelessWidget {
  final EditCourseDialogPresenter _presenter = EditCourseDialogPresenter();
  final Course initialCourse;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final DropdownController<AssignmentColor> _defaultColorController;

  EditCourseDialog({
    required this.initialCourse,
    super.key,
  }) {
    _nameController = TextEditingController(
      text: initialCourse.name,
    );

    _defaultColorController = DropdownController<AssignmentColor>(
      value: initialCourse.defaultAssignmentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Edit Course',
      content: Column(
        children: [
          CourseFormWidget(
            formKey: _formKey,
            nameController: _nameController,
            defaultColorController: _defaultColorController,
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _validateFormAndUpdateCourse(context);
                  },
                  child: const Text('Update'),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    _deleteCourse();
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

  void _validateFormAndUpdateCourse(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _presenter.updateCourse(
        initialCourse.id,
        _nameController.text,
        _defaultColorController.value!,
      );

      Navigator.pop(context);
    }
  }

  void _deleteCourse() {
    _presenter.deleteCourse(initialCourse.id);
  }
}
