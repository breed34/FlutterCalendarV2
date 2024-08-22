import 'package:calendar_v2/constants.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/tasks/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class ColorDropdownWidget extends StatefulWidget {
  final String label;
  final bool required;
  late final DropdownController<TaskColor> _controller;

  ColorDropdownWidget({
    required this.label,
    this.required = false,
    controller,
    super.key,
  }) {
    _controller = controller ?? DropdownController<TaskColor>();
  }

  @override
  State<ColorDropdownWidget> createState() => _ColorDropdownWidgetState();
}

class _ColorDropdownWidgetState extends State<ColorDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._controller.getStream(),
      builder: (context, snapshot) => FormField<TaskColor>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validate,
        initialValue: snapshot.data,
        builder: (state) => DropdownMenu<TaskColor>(
          label: Text(widget.label),
          requestFocusOnTap: false,
          expandedInsets: EdgeInsets.zero,
          trailingIcon: _getTrailingIcon(snapshot.data),
          errorText: state.errorText,
          initialSelection: snapshot.data,
          dropdownMenuEntries: _buildDropdownMenuEntries(),
          onSelected: (value) {
            state.didChange(value);
            widget._controller.value = value;
          },
        ),
      ),
    );
  }

  String? _validate(TaskColor? value) {
    if (value == null && widget.required) {
      return Constants.requiredError;
    }

    return null;
  }

  List<DropdownMenuEntry<TaskColor>> _buildDropdownMenuEntries() {
    return TaskColor.values
        .where((c) => c != TaskColor.none)
        .map(
          (c) => DropdownMenuEntry<TaskColor>(
            value: c,
            label: _formatNameAsLabel(c.name),
            trailingIcon: _getTrailingIcon(c),
          ),
        )
        .toList();
  }

  String _formatNameAsLabel(String name) {
    return name.replaceFirst(name[0], name[0].toUpperCase());
  }

  Widget? _getTrailingIcon(TaskColor? value) {
    if (value == null) {
      return null;
    }

    return Icon(
      Icons.circle,
      color: value.color,
    );
  }
}
