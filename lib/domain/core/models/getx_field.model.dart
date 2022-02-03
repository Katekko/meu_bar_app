import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:get/get.dart';

class GetxFieldModel extends IField {
  final _error = Rxn<String>();

  GetxFieldModel({
    required String value,
    List<IFieldValidator<String>>? validators,
  }) : super(value: value, validators: validators ?? []);

  @override
  Stream<String?> get errorStream => _error.stream;

  @override
  bool get hasError => _error.value != null;

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
