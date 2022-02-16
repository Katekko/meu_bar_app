import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:rxdart/rxdart.dart';

import '../abstractions/presentation/stream_field.interface.dart';

class RxIconFieldModel extends IStreamField<int?> {
  final _stream = BehaviorSubject<int?>();

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
  bool get hasError => _stream.hasError;

  @override
  void onChange(int? val) {
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
