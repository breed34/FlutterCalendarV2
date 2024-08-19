import 'package:rxdart/rxdart.dart';

class DropdownController<T> {
  final BehaviorSubject<T?> _value = BehaviorSubject<T?>();

  T? get value => _value.value;
  set value(T? val) {
    _value.sink.add(val);
  }

  Stream<T?> getStream() {
    return _value.stream;
  }

  DropdownController({value}) {
    this.value = value;
  }
}
