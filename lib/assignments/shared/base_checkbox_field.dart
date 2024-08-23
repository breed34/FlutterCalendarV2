import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CheckBoxController {
  final BehaviorSubject<bool> _value = BehaviorSubject();

  bool get value => _value.value;
  set value(bool val) {
    _value.sink.add(val);
  }

  Stream<bool> getStream() {
    return _value.stream;
  }

  CheckBoxController({value}) {
    this.value = value;
  }
}

class BaseCheckboxField extends StatelessWidget {
  final String label;
  late final CheckBoxController _controller;

  BaseCheckboxField({
    required this.label,
    controller,
    super.key,
  }) {
    _controller = controller ?? CheckBoxController(value: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _controller.getStream(),
      builder: (context, snapshot) => IntrinsicWidth(
        child: Row(
          children: [
            Text(
              label,
              textScaler: const TextScaler.linear(1.2),
            ),
            const SizedBox(width: 16.0),
            Checkbox(
              value: snapshot.data ?? false,
              activeColor: Colors.blue,
              onChanged: (value) {
                _controller.value = value ?? false;
              },
            ),
          ],
        ),
      ),
    );
  }
}
