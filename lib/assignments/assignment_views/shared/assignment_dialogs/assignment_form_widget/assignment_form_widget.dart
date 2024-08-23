import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/assignment_form_widget/course_dropdown_widget/course_dropdown_widget.dart';
import 'package:calendar_v2/assignments/shared/color_dropdown_widget.dart';
import 'package:calendar_v2/assignments/shared/base_checkbox_field.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:calendar_v2/assignments/shared/base_input.dart';
import 'package:flutter/material.dart';

class AssignmentFormWidget extends StatelessWidget {
  final double _fieldSpacing = 12.0;

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final DropdownController<Course> courseController;
  final TextEditingController dueDateController;
  final DropdownController<AssignmentColor> colorController;
  final TextEditingController workLeftController;
  final TextEditingController percentOfGradeController;
  final bool showCompleted;
  final CheckBoxController? completedController;

  AssignmentFormWidget({
    required this.formKey,
    required this.nameController,
    required this.courseController,
    required this.dueDateController,
    required this.colorController,
    required this.workLeftController,
    required this.percentOfGradeController,
    this.showCompleted = false,
    this.completedController,
    super.key,
  }) {
    if (showCompleted && completedController == null) {
      throw Exception("Missing completed controller");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseInput(
            label: "Name",
            required: true,
            controller: nameController,
          ),
          SizedBox(height: _fieldSpacing),
          CourseDropdownWidget(
            label: 'Course',
            required: true,
            controller: courseController,
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
                  controller: dueDateController,
                ),
              ),
              SizedBox(width: _fieldSpacing),
              Flexible(
                flex: 1,
                child: ColorDropdownWidget(
                  label: 'Color',
                  required: true,
                  controller: colorController,
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
                  controller: workLeftController,
                ),
              ),
              SizedBox(width: _fieldSpacing),
              Flexible(
                flex: 1,
                child: BaseInput(
                  label: "% Of Grade",
                  type: BaseInputType.decimal,
                  required: true,
                  controller: percentOfGradeController,
                ),
              ),
            ],
          ),
          SizedBox(height: _fieldSpacing / 2),
          ..._buildCompletedField(),
        ],
      ),
    );
  }

  List<Widget> _buildCompletedField() {
    if (showCompleted) {
      return [
        BaseCheckboxField(
          label: 'Completed',
          controller: completedController,
        ),
        SizedBox(height: _fieldSpacing),
      ];
    }

    return [];
  }
}
