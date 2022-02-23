import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class EmailValidator<T> extends Equatable implements IFieldValidator<T> {
  @override
  String? validate(T? value) {
    if (value is String) {
      String? error;

      bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(value);

      error = !emailValid ? ValidatorsTranslate.invalidEmail : null;

      return error;
    }

    throw TypeError();
  }

  @override
  List<Object?> get props => [];
}
