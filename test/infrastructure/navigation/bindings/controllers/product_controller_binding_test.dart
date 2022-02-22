import 'package:ekko/domain/core/validators/string_validators/required_string_field.validator.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct controller', () {
    final controller = makeProductController(isEdit: false);
    expect(
      controller.nameField.validators,
      [RequiredStringFieldValidator()],
    );
  });
}
