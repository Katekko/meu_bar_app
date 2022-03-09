import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:get/get.dart';

/// Passar apenas valores primitivos
/// double, int, float, num, string
class GetxFieldModel<T> extends IField<T> {
  T? _value;
  final _error = Rxn<String>();

  GetxFieldModel({
    T? value,
    List<IFieldValidator<T>>? validators,
  })  : _value = value,
        super(validators: validators ?? []);

  @override
  T? get value => _value;

  @override
  set value(T? val) {
    onChange(val?.toString());
  }

  @override
  Stream<String?> get errorStream => _error.stream;

  @override
  bool get hasError => _error.value != null;

  @override
  void onChange(String? val) {
    if (val != null) {
      if ((runtimeType == GetxFieldModel<double>) ||
          runtimeType == GetxFieldModel<int>) {
        dynamic parse;
        final onlyNumber = val.replaceAll(RegExp('[^0-9.]'), '');
        parse = num.tryParse(onlyNumber);
        _value = parse;
      } else if (runtimeType == GetxFieldModel<String>) {
        _value = val as T;
      }
    }

    validate();
    onChangeCallback?.call(_value);
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
