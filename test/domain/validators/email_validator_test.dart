import 'package:ekko/domain/core/validators/string_validators/email.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

void main() {
  late EmailValidator sut;

  setUp(() {
    sut = EmailValidator();
  });

  test('Should return null if value is a e-mail', () {
    final email = faker.internet.email();
    expect(sut.validate(email), null);
  });

  test('Should return error if value is not a valid e-mail', () {
    expect(sut.validate('katekko.god@'), ValidatorsTranslate.invalidEmail);
  });
}
