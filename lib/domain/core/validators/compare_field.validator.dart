import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:equatable/equatable.dart';

class CompareFieldValidator<T> extends Equatable implements IFieldValidator<T> {
  final IField fieldToCompare;
  const CompareFieldValidator(this.fieldToCompare);

  @override
  String? validate(T value) {
    if (value is String) {
      return value == fieldToCompare.value
          ? null
          : ValidatorsTranslate.fieldsDontMatch;
    }

    throw TypeError();
  }

  @override
  List<Object?> get props => [fieldToCompare];
}
