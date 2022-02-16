import 'package:ekko/domain/core/validators/string_validators/password.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:test/test.dart';

void main() {
  late PasswordValidator sut;

  setUp(() {
    sut = PasswordValidator();
  });

  test('Should return null if value is more then 3 characters', () {
    expect(sut.validate('1234'), null);
  });

  test('Should return error if value is less then 4 characters', () {
    expect(sut.validate('123'), ValidatorsTranslate.invalidPassword);
  });
}
