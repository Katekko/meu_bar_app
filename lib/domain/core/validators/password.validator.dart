import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class PasswordValidator<T> extends Equatable implements IFieldValidator<T> {
  @override
  String? validate(T? value) {
    if (value is String) {
      String? error;
      if (value.length <= 3) error = ValidatorsTranslate.invalidPassword;
      return error;
    }

    throw TypeError();
  }

  @override
  List<Object?> get props => [];
}
