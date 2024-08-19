import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_form_widget/calendar_dropdown_widget/calendar_dropdown_widget.dart';
import 'package:calendar_v2/modules/calendar/tasks/dialogs/task_form_widget/color_dropdown_widget/color_dropdown_widget.dart';
import 'package:calendar_v2/shared/base_dropdown.dart';
import 'package:calendar_v2/shared/base_input.dart';
import 'package:flutter/material.dart';

class TaskFormWidget extends StatelessWidget {
  final double _fieldSpacing = 12.0;

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final DropdownController<Calendar> calendarController;
  final TextEditingController dueDateController;
  final DropdownController<TaskColor> colorController;
  final TextEditingController workLeftController;
  final TextEditingController importanceController;

  const TaskFormWidget({
    required this.formKey,
    required this.nameController,
    required this.calendarController,
    required this.dueDateController,
    required this.colorController,
    required this.workLeftController,
    required this.importanceController,
    super.key,
  });

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
          CalendarDropdownWidget(
            label: 'Calendar',
            required: true,
            controller: calendarController,
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
                  label: "Importance",
                  type: BaseInputType.decimal,
                  required: true,
                  controller: importanceController,
                ),
              ),
            ],
          ),
          SizedBox(height: _fieldSpacing),
        ],
      ),
    );
  }
}
