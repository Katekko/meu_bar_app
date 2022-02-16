import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';

import '../validators/shared/compare_field.validator.dart';
import '../validators/string_validators/email.validator.dart';
import '../validators/string_validators/password.validator.dart';
import '../validators/string_validators/required_string_field.validator.dart';

class StringFieldValidatorBuilder {
  final List<IFieldValidator<String>> _validators = [];

  StringFieldValidatorBuilder required() {
    _validators.add(RequiredStringFieldValidator());
    return this;
  }

  StringFieldValidatorBuilder password() {
    _validators.add(PasswordValidator());
    return this;
  }

  StringFieldValidatorBuilder email() {
    _validators.add(EmailValidator());
    return this;
  }

  StringFieldValidatorBuilder sameAs(IField fieldToCompare) {
    _validators.add(CompareFieldValidator(fieldToCompare));
    return this;
  }

  List<IFieldValidator<String>> build() => _validators;
}
