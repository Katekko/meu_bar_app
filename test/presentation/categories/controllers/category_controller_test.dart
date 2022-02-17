import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/domain/product/product_mock.repository.dart';
import 'package:ekko/presentation/categories/controllers/category.controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late ICategoryController controller;
  late final IProductRepository productRepository;
  late final IField<String> nameField;
  late final IStreamField<int?> iconField;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    nameField = FieldMock<String>();
    iconField = FieldStreamMock<int?>();
  });

  setUp(() {
    controller = CategoryController(
      productRepository: productRepository,
      loading: LoadingControllerMock(),
      isEdit: false,
      nameField: nameField,
      iconField: iconField,
    );
  });

  test('pickAnIcon should pick correct icon', () {
    const value = 1;
    when(() => iconField.onChange(value)).thenReturn(null);
    when(() => iconField.value).thenReturn(value);
    controller.iconField.value = value;
    expect(controller.iconField.value, value);
  });

  group('Save Categories', () {
    test('should create a category with success', () async {
      const name = 'katekko';
      const icon = 1;
      when(() => nameField.validate()).thenReturn(true);
      when(() => nameField.value).thenReturn(name);
      when(() => nameField.hasError).thenReturn(false);

      when(() => iconField.validate()).thenReturn(true);
      when(() => iconField.value).thenReturn(icon);
      when(() => iconField.hasError).thenReturn(false);

      controller.iconField.value = icon;
      controller.nameField.value = name;
      final category = CategoryModel(
        id: -1,
        name: controller.nameField.value,
        icon: controller.iconField.value!,
      );

      when(() => productRepository.registerCategory(category))
          .thenAnswer((_) async {});

      await controller.saveCategory(backScreen: () {});

      verify(() => productRepository.registerCategory(category));
    });

    test('should update a category with success', () async {
      const name = 'katekko';
      const icon = 1;
      when(() => nameField.validate()).thenReturn(true);
      when(() => nameField.value).thenReturn(name);
      when(() => nameField.hasError).thenReturn(false);

      when(() => iconField.validate()).thenReturn(true);
      when(() => iconField.value).thenReturn(icon);
      when(() => iconField.hasError).thenReturn(false);

      const category = CategoryModel(id: 1, name: name, icon: icon);

      final controller = CategoryController(
        productRepository: productRepository,
        loading: LoadingControllerMock(),
        isEdit: true,
        nameField: nameField,
        iconField: iconField,
        category: category,
      );

      controller.iconField.value = 2;
      controller.nameField.value = 'katekko 2';

      final categoryToSave = CategoryModel(
        id: 1,
        name: controller.nameField.value,
        icon: controller.iconField.value!,
      );

      when(() => productRepository.updateCategory(categoryToSave))
          .thenAnswer((_) async {});

      await controller.saveCategory(backScreen: () {});

      verify(() => productRepository.updateCategory(categoryToSave));
    });
  });

  group('Validate Fields', () {
    test('should return true', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(iconField.validate).thenReturn(true);
      when(() => iconField.hasError).thenReturn(false);

      controller.iconField.value = 1;

      final response = controller.validateFields();

      expect(response, true);
    });

    test('should return false when icon is null', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(iconField.validate).thenReturn(false);
      when(() => iconField.hasError).thenReturn(true);

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when nameField is invalid', () {
      when(nameField.validate).thenReturn(false);
      when(() => nameField.hasError).thenReturn(true);

      when(iconField.validate).thenReturn(true);
      when(() => iconField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, false);
    });
  });

  test('onInit should initiate fields when a category is passed', () {
    controller = CategoryController(
      productRepository: productRepository,
      loading: LoadingControllerMock(),
      isEdit: false,
      nameField: nameField,
      iconField: iconField,
      category: categoryModel1,
    );

    controller.onInit();

    verify(() => nameField.value = categoryModel1.name);
    verify(() => iconField.value = categoryModel1.icon);
  });

  test('onInit should never initiate fields when a category is not passed', () {
    controller = CategoryController(
      productRepository: productRepository,
      loading: LoadingControllerMock(),
      isEdit: false,
      nameField: nameField,
      iconField: iconField,
    );

    controller.onInit();

    verifyNever(() => nameField.value = categoryModel1.name);
    verifyNever(() => iconField.value = categoryModel1.icon);
  });

  test('onClose should call all field disposes', () {
    controller.onClose();

    verify(nameField.dispose);
    verify(iconField.dispose);
  });
}
