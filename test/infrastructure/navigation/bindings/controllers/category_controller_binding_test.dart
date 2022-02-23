import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/builders/field_validator.builder.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:test/test.dart';

import '../../../../mocks.dart';

// TODO: Criar teste para categories controller binding

void main() {
  late IProductRepository productRepository;
  late ILoadingController loading;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    loading = LoadingControllerMock();
  });

  test('Should return correct name field', () {
    final field = makeCategoryNameField();
    expect(field.value, '');
    expect(
      field.validators,
      FieldValidatorBuilder<String>().required().build(),
    );
    expect(field.hasError, false);
  });

  test('Should return the correct controller with isEdit true', () {
    final controller = makeCategoryController(
      productRepository: productRepository,
      loading: loading,
      isEdit: true,
      nameField: makeCategoryNameField(),
      iconField: makeCategoryIconField(),
    );
    expect(controller, isA<CategoryController>());
    expect(controller.isEdit, true);
    expect(controller.nameField, makeCategoryNameField());
  });

  test('Should return the correct controller with isEdit false', () {
    final controller = makeCategoryController(
      productRepository: productRepository,
      loading: loading,
      isEdit: false,
      nameField: makeCategoryNameField(),
      iconField: makeCategoryIconField(),
    );
    expect(controller, isA<CategoryController>());
    expect(controller.isEdit, false);
    expect(controller.nameField, makeCategoryNameField());
  });
}
