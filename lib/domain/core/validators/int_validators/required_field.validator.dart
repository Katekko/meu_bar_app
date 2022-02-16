import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class RequiredIntFieldValidator extends Equatable
    implements IFieldValidator<int?> {
  @override
  String? validate(int? value) {
    return value == null || value == 0
        ? ValidatorsTranslate.requiredField
        : null;
  }

  @override
  List<Object?> get props => [];
}
