import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class RequiredFieldValidator extends Equatable
    implements IFieldValidator<String> {
  @override
  String? validate(String value) {
    return value.isEmpty ? ValidatorsTranslate.requiredField : null;
  }

  @override
  List<Object?> get props => [];
}
