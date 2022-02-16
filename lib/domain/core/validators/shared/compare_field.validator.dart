import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class CompareFieldValidator extends Equatable
    implements IFieldValidator<String> {
  final IField fieldToCompare;
  const CompareFieldValidator(this.fieldToCompare);

  @override
  String? validate(String value) {
    return value == fieldToCompare.value
        ? null
        : ValidatorsTranslate.fieldsDontMatch;
  }

  @override
  List<Object?> get props => [fieldToCompare];
}
