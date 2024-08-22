import 'package:calendar_v2/constants.dart';
import 'package:calendar_v2/models/calendar.dart';
import 'package:calendar_v2/modules/tasks/dialogs/task_dialogs/task_form_widget/calendar_dropdown_widget/calendar_dropdown_widget_presenter.dart';
import 'package:calendar_v2/shared/base_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CalendarDropdownWidget extends StatefulWidget {
  final String label;
  final bool required;
  late final DropdownController<Calendar> _controller;

  CalendarDropdownWidget({
    required this.label,
    this.required = false,
    controller,
    super.key,
  }) {
    _controller = controller ?? DropdownController();
  }

  @override
  State<CalendarDropdownWidget> createState() => _CalendarDropdownWidgetState();
}

class _CalendarDropdownWidgetState extends State<CalendarDropdownWidget> {
  final CalendarDropdownWidgetPresenter _presenter =
      CalendarDropdownWidgetPresenter();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, Object?>>(
      stream: Rx.combineLatest2(
        widget._controller.getStream(),
        _presenter.getCalendars(),
        (value, calendars) => {
          "value": value,
          "calendars": calendars,
        },
      ),
      builder: (context, snapshot) => FormField<Calendar>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validate,
        initialValue: snapshot.data?['value'] as Calendar?,
        builder: (state) => DropdownMenu<Calendar>(
          label: Text(widget.label),
          requestFocusOnTap: false,
          expandedInsets: EdgeInsets.zero,
          trailingIcon: _getTrailingIcon(snapshot.data?['value'] as Calendar?),
          errorText: state.errorText,
          initialSelection: snapshot.data?['value'] as Calendar?,
          dropdownMenuEntries: _buildDropdownMenuEntries(
            snapshot.data?["calendars"] as List<Calendar>?,
          ),
          onSelected: (value) {
            state.didChange(value);
            widget._controller.value = value;
          },
        ),
      ),
    );
  }

  String? _validate(Calendar? value) {
    if (value == null && widget.required) {
      return Constants.requiredError;
    }

    return null;
  }

  List<DropdownMenuEntry<Calendar>> _buildDropdownMenuEntries(
      List<Calendar>? calendars) {
    if (calendars == null) {
      return [];
    }

    return calendars
        .map(
          (c) => DropdownMenuEntry<Calendar>(
            value: c,
            label: c.name,
            trailingIcon: _getTrailingIcon(c),
          ),
        )
        .toList();
  }

  Widget? _getTrailingIcon(Calendar? value) {
    if (value == null) {
      return null;
    }

    return Icon(
      Icons.circle,
      color: value.defaultTaskColor.color,
    );
  }
}
