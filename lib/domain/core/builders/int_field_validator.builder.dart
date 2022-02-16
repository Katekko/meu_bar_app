import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';

import '../validators/int_validators/required_field.validator.dart';

class IntFieldValidatorBuilder {
  final List<IFieldValidator<int?>> _validators = [];

  IntFieldValidatorBuilder required() {
    _validators.add(RequiredIntFieldValidator());
    return this;
  }

  List<IFieldValidator<int?>> build() => _validators;
}
