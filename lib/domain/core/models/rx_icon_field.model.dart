import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:rxdart/rxdart.dart';

import '../abstractions/presentation/stream_field.interface.dart';

class RxIconFieldModel extends IStreamField<int?> {
  final _stream = BehaviorSubject<int?>();
  final _error = BehaviorSubject<String>();

  RxIconFieldModel({
    int? value,
    List<IFieldValidator<int?>>? validators,
  }) : super(validators: validators ?? []) {
    _stream.add(value);
  }

  @override
  Stream<int?> get stream => _stream;

  @override
  int? get value => _stream.value;

  @override
  set value(int? val) => onChange(val);

  @override
  Stream<String?> get errorStream => _error.stream;

  @override
  bool get hasError => _error.value != null;

  @override
  void onChange(int? val) {
    _stream.add(val);
    validate();
    onChangeCallback?.call(val);
  }

  @override
  bool validate() {
    final error = super.validateValue(_stream.value);
    if (error != null) _error.add(error);
    return _error.value != null;
  }

  @override
  void dispose() {
    _stream.close();
    _error.close();
  }
}
