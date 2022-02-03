import 'package:ekko/domain/core/builders/field_validator.builder.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/login.controller.binding.dart';
import 'package:test/test.dart';

import '../../../../mocks.dart';

void main() {
  test('Should return the correct login field', () {
    final field = makeLoginField();
    expect(field.value, '');
    expect(field.validators, FieldValidatorBuilder().required().build());
    expect(field.hasError, false);
  });

  test('Should return the correct password field', () {
    final field = makePasswordField();
    expect(field.value, '');
    expect(
      field.validators,
      FieldValidatorBuilder().required().password().build(),
    );
    expect(field.hasError, false);
  });

  test('Should return the correct controller model', () {
    final authRepositorySpy = AuthRepositoryMock();
    final loadingSpy = LoadingControllerMock();

    final controller = makeLoginController(
      authRepository: authRepositorySpy,
      loading: loadingSpy,
    );

    expect(controller.currentLogin, makeLoginField());
    expect(controller.currentPassword, makePasswordField());
  });
}
