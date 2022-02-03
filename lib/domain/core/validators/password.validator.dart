import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class PasswordFieldValidator extends Equatable
    implements IFieldValidator<String> {
  @override
  String? validate(String value) {
    String? error;
    if (value.length <= 3) error = ValidatorsTranslate.invalidPassword;
    return error;
  }

  @override
  List<Object?> get props => [];
}
