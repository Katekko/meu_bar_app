import 'package:ekko/domain/core/validators/string_validators/required_string_field.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:test/test.dart';

void main() {
  late RequiredStringFieldValidator sut;

  setUp(() {
    sut = RequiredStringFieldValidator();
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidatorsTranslate.requiredField);
  });
}
