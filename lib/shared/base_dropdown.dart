import 'package:calendar_v2/constants.dart';
import 'package:flutter/material.dart';

class DropdownController<T> {
  T? value;

  DropdownController({this.value});
}

class BaseDropdown<T> extends StatefulWidget {
  final bool required;
  late final DropdownController<T> _controller;

  BaseDropdown({
    this.required = false,
    controller,
    super.key,
  }) {
    _controller = controller ?? DropdownController<T>();
  }

  @override
  State<BaseDropdown<T>> createState() => BaseDropdownState();
}

class BaseDropdownState<T, U extends BaseDropdown<T>> extends State<U> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  String? validate(T? value) {
    var requiredError = Constants.requiredError;
    if (value == null && widget.required) {
      return requiredError;
    } else if (value != null &&
        value is String &&
        value.isEmpty &&
        widget.required) {
      return requiredError;
    }

    return null;
  }

  void setControllerValue(T? value) {
    widget._controller.value = value;
  }

  T? getControllerValue() {
    return widget._controller.value;
  }
}
