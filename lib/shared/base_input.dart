import 'package:calendar_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BaseInputType {
  none,
  text,
  datetime,
  decimal,
}

class BaseInput extends StatelessWidget {
  final String label;
  final BaseInputType type;
  final bool required;
  final String? initialValue;
  final TextEditingController? controller;

  const BaseInput({
    required this.label,
    this.type = BaseInputType.text,
    this.required = false,
    this.initialValue,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BaseInputType.text:
        return _BaseTextInput(
          label: label,
          required: required,
          initialValue: initialValue,
          controller: controller,
        );
      case BaseInputType.datetime:
        return _BaseDateTimeInput(
          label: label,
          required: required,
          initialValue: initialValue,
          controller: controller,
        );
      case BaseInputType.decimal:
        return _BaseDecimalInput(
          label: label,
          required: required,
          initialValue: initialValue,
          controller: controller,
        );
      default:
        throw Exception('Unexpected type: $type');
    }
  }
}

abstract class _AbstractInput extends StatelessWidget {
  final String label;
  final bool required;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String?)? customValidator;

  const _AbstractInput({
    required this.label,
    required this.required,
    required this.initialValue,
    required this.controller,
    this.customValidator,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  String? validate(String? value) {
    var requiredError = Constants.requiredError;
    if (value == null && required) {
      return requiredError;
    } else if (value != null && value.isEmpty && required) {
      return requiredError;
    }

    if (customValidator != null) {
      return customValidator!(value);
    }

    return null;
  }
}

class _BaseTextInput extends _AbstractInput {
  const _BaseTextInput({
    required super.label,
    required super.required,
    required super.initialValue,
    required super.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}

class _BaseDateTimeInput extends _AbstractInput {
  const _BaseDateTimeInput({
    required super.label,
    required super.required,
    required super.initialValue,
    required super.controller,
  }) : super(customValidator: _validateDate);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.datetime,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d|\/'))],
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: "mm/dd/yyyy",
      ),
    );
  }

  static String? _validateDate(String? value) {
    var monthMatch = r'((0[1-9])|(1[0-2]))';
    var dayMatch = r'((0[1-9])|([1-2]\d)|(3[0-1]))';
    var yearMatch = r'((19(\d{2}))|(2[0-1](\d{2})))';
    var dateMatch =
        r'^' + monthMatch + r'\/' + dayMatch + r'\/' + yearMatch + r'$';

    if (value != null && !RegExp(dateMatch).hasMatch(value)) {
      return 'Please enter a valid date.';
    }

    return null;
  }
}

class _BaseDecimalInput extends _AbstractInput {
  const _BaseDecimalInput({
    required super.label,
    required super.required,
    required super.initialValue,
    required super.controller,
  }) : super(customValidator: _validateDecimal);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: true,
      ),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d|\.'))],
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  static String? _validateDecimal(String? value) {
    if (value != null && !RegExp(r'^\d+\.{0,1}\d*$').hasMatch(value)) {
      return 'Please enter a valid decimal value.';
    }

    return null;
  }
}
