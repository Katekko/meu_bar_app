import 'package:ekko/domain/core/validators/required_field.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RequiredFieldValidator sut;

  setUp(() {
    sut = RequiredFieldValidator();
  });

  test('Should return error if value is null', () {
    expect(sut.validate(null), ValidatorsTranslate.requiredField);
  });

  test('Should return null if value is not empty', () {
    expect(sut.validate(faker.lorem.random.string(10)), null);
  });

  test('Should return null if value is a number greater then zero', () {
    expect(sut.validate(faker.currency.random.integer(20, min: 1)), null);
  });

  test('Should return error if value is empty', () {
    expect(sut.validate(''), ValidatorsTranslate.requiredField);
  });

  test('Should return error if value is zero', () {
    expect(sut.validate(0), ValidatorsTranslate.requiredField);
  });
}
