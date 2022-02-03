import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:get/get.dart';

import 'login.translate.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {}
          ..addAll(LoginTranslate.translateEN)
          ..addAll(ValidatorsTranslate.translateEN),
        'pt_BR': {}
          ..addAll(LoginTranslate.translatePTBR)
          ..addAll(ValidatorsTranslate.translatePTBR),
      };
}
