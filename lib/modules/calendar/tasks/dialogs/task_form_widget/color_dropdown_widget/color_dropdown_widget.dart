import 'package:calendar_v2/models/enums.dart';
import 'package:calendar_v2/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class ColorDropdownWidget extends BaseDropdown<TaskColor> {
  final String label;

  ColorDropdownWidget({
    required this.label,
    super.controller,
    super.required = false,
    super.key,
  });

  @override
  State<ColorDropdownWidget> createState() => _ColorDropdownWidgetState();
}

class _ColorDropdownWidgetState
    extends BaseDropdownState<TaskColor, ColorDropdownWidget> {
  Widget? _trailingIcon;

  @override
  Widget build(BuildContext context) {
    if (getControllerValue() != null) {
      _trailingIcon = _getTrailingIcon(getControllerValue());
    }

    return FormField<TaskColor>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validate,
      builder: (state) => DropdownMenu<TaskColor>(
        label: Text(widget.label),
        requestFocusOnTap: false,
        dropdownMenuEntries: _buildDropdownMenuEntries(),
        initialSelection: getControllerValue(),
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

  Widget? _getTrailingIcon(TaskColor? taskColor) {
    if (taskColor == null) {
      return null;
    }

    return Icon(
      Icons.circle,
      color: taskColor.color,
    );
  }

  List<DropdownMenuEntry<TaskColor>> _buildDropdownMenuEntries() {
    return TaskColor.values
        .where((c) => c != TaskColor.none)
        .map((c) => DropdownMenuEntry(
              value: c,
              label: _formatNameAsLabel(c.name),
              trailingIcon: _getTrailingIcon(c),
            ))
        .toList();
  }

  String _formatNameAsLabel(String name) {
    return name.replaceFirst(name[0], name[0].toUpperCase());
  }
}
