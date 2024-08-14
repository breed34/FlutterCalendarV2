import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/task/dialogs/add_task_dialog/calendar_dropdown_widget/calendar_dropdown_widget_presenter.dart';
import 'package:calendar_v2/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class CalendarDropdownWidget extends BaseDropdown<Calendar> {
  final String label;

  CalendarDropdownWidget({
    required this.label,
    super.controller,
    super.required = false,
    super.key,
  });

  @override
  State<CalendarDropdownWidget> createState() => _CalendarDropdownWidgetState();
}

class _CalendarDropdownWidgetState
    extends BaseDropdownState<Calendar, CalendarDropdownWidget> {
  final CalendarDropdownWidgetPresenter _presenter =
      CalendarDropdownWidgetPresenter();
  Widget? _trailingIcon;

  @override
  Widget build(BuildContext context) {
    return FormField<Calendar>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validate,
      builder: (state) => DropdownMenu<Calendar>(
        label: Text(widget.label),
        requestFocusOnTap: false,
        dropdownMenuEntries: _buildDropdownMenuEntries(),
        expandedInsets: EdgeInsets.zero,
        trailingIcon: _trailingIcon,
        errorText: state.errorText,
        onSelected: (value) {
          setControllerValue(value);
          state.didChange(value);
          setState(() {
            _trailingIcon = _getTrailingIcon(value);
          });
        },
      ),
    );
  }

  List<DropdownMenuEntry<Calendar>> _buildDropdownMenuEntries() {
    return _presenter
        .getCalendars()
        .map((c) => DropdownMenuEntry(
              value: c,
              label: c.name,
              trailingIcon: _getTrailingIcon(c),
            ))
        .toList();
  }

  Widget? _getTrailingIcon(Calendar? calendar) {
    if (calendar == null) {
      return null;
    }

    return Icon(
      Icons.circle,
      color: calendar.defaultTaskColor.color,
    );
  }
}
