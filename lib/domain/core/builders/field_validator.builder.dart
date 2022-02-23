import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';

import '../validators/compare_field.validator.dart';
import '../validators/email.validator.dart';
import '../validators/password.validator.dart';
import '../validators/required_field.validator.dart';

class FieldValidatorBuilder<T> {
  final List<IFieldValidator<T>> _validators = [];

  FieldValidatorBuilder<T> required() {
    _validators.add(RequiredFieldValidator<T>());
    return this;
  }

  FieldValidatorBuilder<T> password() {
    _validators.add(PasswordValidator<T>());
    return this;
  }

  FieldValidatorBuilder<T> email() {
    _validators.add(EmailValidator<T>());
    return this;
  }

  FieldValidatorBuilder<T> sameAs(IField fieldToCompare) {
    _validators.add(CompareFieldValidator<T>(fieldToCompare));
    return this;
  }

  List<IFieldValidator<T>> build() => _validators;
}
