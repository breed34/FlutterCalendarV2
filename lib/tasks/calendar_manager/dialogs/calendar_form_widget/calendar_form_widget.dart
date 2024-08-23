import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/tasks/shared/color_dropdown_widget.dart';
import 'package:calendar_v2/tasks/shared/base_dropdown.dart';
import 'package:calendar_v2/tasks/shared/base_input.dart';
import 'package:flutter/material.dart';

class CalendarFormWidget extends StatelessWidget {
  final double _fieldSpacing = 12.0;

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final DropdownController<TaskColor> defaultColorController;

  const CalendarFormWidget({
    required this.formKey,
    required this.nameController,
    required this.defaultColorController,
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
          ColorDropdownWidget(
            label: "Default Task Color",
            required: true,
            controller: defaultColorController,
          ),
          SizedBox(height: _fieldSpacing),
        ],
      ),
    );
  }
}
