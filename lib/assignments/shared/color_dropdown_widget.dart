import 'package:calendar_v2/constants.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:calendar_v2/assignments/shared/base_dropdown.dart';
import 'package:flutter/material.dart';

class ColorDropdownWidget extends StatefulWidget {
  final String label;
  final bool required;
  late final DropdownController<AssignmentColor> _controller;

  ColorDropdownWidget({
    required this.label,
    this.required = false,
    controller,
    super.key,
  }) {
    _controller = controller ?? DropdownController<AssignmentColor>();
  }

  @override
  State<ColorDropdownWidget> createState() => _ColorDropdownWidgetState();
}

class _ColorDropdownWidgetState extends State<ColorDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._controller.getStream(),
      builder: (context, snapshot) => FormField<AssignmentColor>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validate,
        initialValue: snapshot.data,
        builder: (state) => DropdownMenu<AssignmentColor>(
          label: Text(widget.label),
          menuHeight: 200.0,
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

  String? _validate(AssignmentColor? value) {
    if (value == null && widget.required) {
      return Constants.requiredError;
    }

    return null;
  }

  List<DropdownMenuEntry<AssignmentColor>> _buildDropdownMenuEntries() {
    return AssignmentColor.values
        .where((c) => c != AssignmentColor.none)
        .map(
          (c) => DropdownMenuEntry<AssignmentColor>(
            value: c,
            label: c.displayName!,
            trailingIcon: _getTrailingIcon(c),
          ),
        )
        .toList();
  }

  Widget? _getTrailingIcon(AssignmentColor? value) {
    if (value == null) {
      return null;
    }

    return Icon(
      Icons.circle,
      color: value.color,
    );
  }
}
