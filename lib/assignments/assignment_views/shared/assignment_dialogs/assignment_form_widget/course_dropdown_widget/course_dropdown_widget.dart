import 'package:calendar_v2/constants.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_dialogs/assignment_form_widget/course_dropdown_widget/course_dropdown_widget_presenter.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CourseDropdownWidget extends StatefulWidget {
  final String label;
  final bool required;
  final void Function(Course? selection)? onSelected;
  late final DropdownController<Course> _controller;

  CourseDropdownWidget({
    required this.label,
    this.required = false,
    this.onSelected,
    controller,
    super.key,
  }) {
    _controller = controller ?? DropdownController();
  }

  @override
  State<CourseDropdownWidget> createState() => _CourseDropdownWidgetState();
}

class _CourseDropdownWidgetState extends State<CourseDropdownWidget> {
  final CourseDropdownWidgetPresenter _presenter =
      CourseDropdownWidgetPresenter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<List<Course>>>(
      future: _presenter.getCourses(),
      builder: (context, fSnapshot) {
        if (fSnapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<Map<String, Object?>>(
            stream: Rx.combineLatest2(
              widget._controller.getStream(),
              fSnapshot.data!,
              (value, courses) => {
                "value": value,
                "courses": courses,
              },
            ),
            builder: (context, sSnapshot) => FormField<Course>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _validate,
              initialValue: sSnapshot.data?['value'] as Course?,
              builder: (state) => DropdownMenu<Course>(
                label: Text(widget.label),
                requestFocusOnTap: false,
                expandedInsets: EdgeInsets.zero,
                trailingIcon:
                    _getTrailingIcon(sSnapshot.data?['value'] as Course?),
                errorText: state.errorText,
                initialSelection: sSnapshot.data?['value'] as Course?,
                dropdownMenuEntries: _buildDropdownMenuEntries(
                  sSnapshot.data?["courses"] as List<Course>?,
                ),
                onSelected: (value) {
                  state.didChange(value);
                  widget._controller.value = value;
                  if (widget.onSelected != null) {
                    widget.onSelected!(value);
                  }
                },
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  String? _validate(Course? value) {
    if (value == null && widget.required) {
      return Constants.requiredError;
    }

    return null;
  }

  List<DropdownMenuEntry<Course>> _buildDropdownMenuEntries(
      List<Course>? courses) {
    if (courses == null) {
      return [];
    }

    return courses
        .map(
          (c) => DropdownMenuEntry<Course>(
            value: c,
            label: c.name,
            trailingIcon: _getTrailingIcon(c),
          ),
        )
        .toList();
  }

  Widget? _getTrailingIcon(Course? value) {
    if (value == null) {
      return null;
    }

    return Icon(
      Icons.circle,
      color: value.defaultAssignmentColor.color,
    );
  }
}
