import 'package:ekko/domain/core/validators/email.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EmailValidator sut;

  setUp(() {
    sut = EmailValidator();
  });

  test('Should return null if value is a e-mail', () {
    expect(sut.validate(faker.internet.email()), null);
  });

  test('Should return error if value is not a valid e-mail', () {
    expect(sut.validate('katekko.god@'), ValidatorsTranslate.invalidEmail);
  });
}
