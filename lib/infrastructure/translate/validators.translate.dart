import 'package:get/get.dart';

class ValidatorsTranslate {
  ValidatorsTranslate._();
  static const _initial = 'validators';

  static const _requiredField = '$_initial-required-field';
  static String get requiredField => _requiredField.tr;

  static const _invalidEmail = '$_initial-invalid-email';
  static String get invalidEmail => _invalidEmail.tr;

  static const _invalidPassword = '$_initial-invalidPassword';
  static String get invalidPassword => _invalidPassword.tr;

  static const _fieldsDontMatch = '$_initial-fields-dont-match';
  static String get fieldsDontMatch => _fieldsDontMatch.tr;

  static Map<String, String> translatePTBR = {
    _requiredField: 'Campo obrigatório',
    _invalidEmail: 'E-mail inválido',
    invalidPassword: 'Senha muito pequena',
    _fieldsDontMatch: 'Campos diferentes',
  };

  static Map<String, String> translateEN = {
    _requiredField: 'Required field',
    _invalidEmail: 'Invalid e-mail',
    _invalidPassword: 'Password is to short',
    _fieldsDontMatch: 'Fields don\'t match',
  };
}
