import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class RequiredFieldValidator<T> extends Equatable
    implements IFieldValidator<T> {
  @override
  String? validate(T? value) {
    if (value == null) return ValidatorsTranslate.requiredField;

    if (value is String) {
      return value.isEmpty ? ValidatorsTranslate.requiredField : null;
    } else if (value is int || value is double || value is num) {
      return value != 0 ? null : ValidatorsTranslate.requiredField;
    }

    return null;
  }

  @override
  List<Object?> get props => [];
}
