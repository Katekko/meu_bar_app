import 'package:ekko/domain/core/validators/compare_field.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  test(
    'Should return null if value is equal the value on the field to compare',
    () {
      final fieldSpy = FieldMock(value: '1234');

      final sut = CompareFieldValidator(fieldSpy);

      final response = sut.validate('1234');

      expect(response, null);
    },
  );

  test(
    'Should return error if value is not equal the value on the field to compare',
    () {
      final fieldSpy = FieldMock(value: '123');

      final sut = CompareFieldValidator(fieldSpy);

      final response = sut.validate('1234');

      expect(response, ValidatorsTranslate.fieldsDontMatch);
    },
  );
}
