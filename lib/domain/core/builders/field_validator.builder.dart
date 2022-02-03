import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/validators/compare_field.validator.dart';
import 'package:ekko/domain/core/validators/email.validator.dart';
import 'package:ekko/domain/core/validators/password.validator.dart';
import 'package:ekko/domain/core/validators/required_field.validator.dart';

class FieldValidatorBuilder {
  final List<IFieldValidator<String>> _validators = [];

  FieldValidatorBuilder required() {
    _validators.add(RequiredFieldValidator());
    return this;
  }

  FieldValidatorBuilder password() {
    _validators.add(PasswordFieldValidator());
    return this;
  }

  FieldValidatorBuilder email() {
    _validators.add(EmailFieldValidator());
    return this;
  }

  FieldValidatorBuilder sameAs(IField fieldToCompare) {
    _validators.add(CompareFieldValidator(fieldToCompare));
    return this;
  }

  List<IFieldValidator<String>> build() => _validators;
}
