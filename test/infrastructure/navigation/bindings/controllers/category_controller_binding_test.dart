import 'package:ekko/domain/core/builders/field_validator.builder.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:test/test.dart';

// TODO: Criar teste para categories controller binding

void main() {
  test('Should correct name field', () {
    final field = makeCategoryNameField();
    expect(field.value, '');
    expect(field.validators, FieldValidatorBuilder().required().build());
    expect(field.hasError, false);
  });

  test('Should return the correct controller with isEdit true', () {
    final controller = makeCategoryController(
      isEdit: true,
      nameField: makeCategoryNameField(),
    );
    expect(controller, isA<CategoryController>());
    expect(controller.isEdit, true);
    expect(controller.nameField, makeCategoryNameField());
  });

  test('Should return the correct controller with isEdit false', () {
    final controller = makeCategoryController(
      isEdit: false,
      nameField: makeCategoryNameField(),
    );
    expect(controller, isA<CategoryController>());
    expect(controller.isEdit, false);
    expect(controller.nameField, makeCategoryNameField());
  });
}
