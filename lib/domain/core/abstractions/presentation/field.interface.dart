import 'package:ekko/domain/core/abstractions/domain/validators/field_validator.interface.dart';
import 'package:ekko/domain/core/abstractions/domain/validators/validator.interface.dart';

abstract class IField<T> extends IValidator<T> {
  set value(T? val);
  T? get value;
  Stream<String?> get errorStream;

  /// Chame esse callback caso queira executar alguma funcionalidade
  /// após o onChange rodar.
  ///
  /// Parametro [val] é o valor retornado pelo onChange do campo
  void Function(T val)? onChangeCallback;

  /// Função utilizada para setar valor do campo
  void onChange(String val);

  IField({
    required List<IFieldValidator<T>> validators,
  }) : super(validators: validators);

  void dispose();

  // Isso daqui ta muito estranho, preciso de ajuda
  @override
  bool operator ==(Object other) {
    if (runtimeType == other.runtimeType) {
      var obj = other as IField;
      if (obj.value != other.value) return false;
      if (validators.length != other.validators.length) return false;
      for (var val1 in validators) {
        final hasThisValidator = other.validators.any((e) => e == val1);
        if (!hasThisValidator) return false;
      }

      return true;
    }

    return false;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
