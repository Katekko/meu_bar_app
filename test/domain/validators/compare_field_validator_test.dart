import 'package:ekko/domain/core/validators/compare_field.validator.dart';
import 'package:ekko/infrastructure/translate/validators.translate.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  test(
    'Should return null if value is equal the value on the field to compare',
    () {
      final fieldSpy = FieldMock();

      when(() => fieldSpy.value).thenReturn('1234');

      final sut = CompareFieldValidator(fieldSpy);

      final response = sut.validate('1234');

      expect(response, null);
    },
  );

  test(
    'Should return error if value is not equal the value on the field to compare',
    () {
      final fieldSpy = FieldMock();

      when(() => fieldSpy.value).thenReturn('123');

      final sut = CompareFieldValidator(fieldSpy);

      final response = sut.validate('1234');

      expect(response, ValidatorsTranslate.fieldsDontMatch);
    },
  );
}
