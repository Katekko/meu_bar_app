import 'package:ekko/domain/core/validators/required_field.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:test/test.dart';

void main() {
  late RequiredFieldValidator sut;

  setUp(() {
    sut = RequiredFieldValidator();
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidatorsTranslate.requiredField);
  });
}
