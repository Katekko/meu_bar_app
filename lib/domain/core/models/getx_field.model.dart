import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:get/get.dart';

class GetxFieldModel extends IField {
  var _value = '';
  final _error = Rxn<String>();

  GetxFieldModel({
    String? value,
    List<IFieldValidator<String>>? validators,
  })  : _value = value ?? '',
        super(validators: validators ?? []);

  @override
  String get value => _value;

  @override
  set value(String val) {
    onChange(val);
  }

  @override
  Stream<String?> get errorStream => _error.stream;

  @override
  bool get hasError => _error.value != null;

  @override
  void onChange(String val) {
    _value = val;
    validate();
    onChangeCallback?.call(val);
  }

  @override
  bool validate() {
    _error.value = super.validateValue(value);
    return _error.value != null;
  }

  @override
  void dispose() {
    _error.close();
  }
}
