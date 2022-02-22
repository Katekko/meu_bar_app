import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:rxdart/rxdart.dart';

import '../abstractions/presentation/stream_field.interface.dart';

class RxFieldModel<T> extends IStreamField<T?> {
  final _stream = BehaviorSubject<T?>();

  RxFieldModel({
    T? value,
    List<IFieldValidator<T?>>? validators,
  }) : super(validators: validators ?? []) {
    _stream.add(value);
  }

  @override
  Stream<T?> get stream => _stream;

  @override
  T? get value => _stream.value;

  @override
  set value(T? val) => onChange(val);

  @override
  bool get hasError => _stream.hasError;

  @override
  void onChange(T? val) {
    _stream.add(val);
    validate();
    onChangeCallback?.call(val);
  }

  @override
  bool validate() {
    final error = super.validateValue(_stream.value);
    if (error != null) _stream.addError(error);
    return !hasError;
  }

  @override
  void dispose() => _stream.close();
}
