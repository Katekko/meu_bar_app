import 'dart:typed_data';

import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/domain/product/product_mock.repository.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late IProductController controller;

  late final IProductRepository productRepository;
  late final ILoadingController loading;

  late final IField<String> nameField;
  late final IField<String> descriptionField;
  late final IField<double> priceField;
  late final IStreamField<CategoryModel?> categoryField;
  late final IStreamField<Uint8List?> imageBytesField;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    loading = LoadingControllerMock();
    nameField = FieldMock<String>();
    descriptionField = FieldMock<String>();
    priceField = FieldMock<double>();
    categoryField = FieldStreamMock<CategoryModel?>();
    imageBytesField = FieldStreamMock<Uint8List?>();
  });

  setUp(() {
    controller = ProductController(
      productRepository: productRepository,
      loading: loading,
      isEdit: false,
      nameField: nameField,
      descriptionField: descriptionField,
      categoryField: categoryField,
      priceField: priceField,
      imageBytesField: imageBytesField,
    );
  });

  test('Should dipose fields when onClose is called', () async {
    await controller.onClose();

    verify(nameField.dispose).called(1);
    verify(descriptionField.dispose).called(1);
    verify(priceField.dispose).called(1);
    verify(categoryField.dispose).called(1);
    verify(imageBytesField.dispose).called(1);
  });

  test('Ensure fields are the same as passed', () {
    expect(controller.nameField, nameField);
    expect(controller.descriptionField, descriptionField);
    expect(controller.priceField, priceField);
    expect(controller.categoryField, categoryField);
    expect(controller.imageBytesField, imageBytesField);
  });

  group('Validate Fields', () {
    test('should return true', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(descriptionField.validate).thenReturn(true);
      when(() => descriptionField.hasError).thenReturn(false);

      when(priceField.validate).thenReturn(true);
      when(() => priceField.hasError).thenReturn(false);

      when(categoryField.validate).thenReturn(true);
      when(() => categoryField.hasError).thenReturn(false);

      when(imageBytesField.validate).thenReturn(true);
      when(() => imageBytesField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, true);
    });

    test('should return false when nameField hasError', () {
      when(nameField.validate).thenReturn(false);
      when(() => nameField.hasError).thenReturn(true);

      when(descriptionField.validate).thenReturn(true);
      when(() => descriptionField.hasError).thenReturn(false);

      when(priceField.validate).thenReturn(true);
      when(() => priceField.hasError).thenReturn(false);

      when(categoryField.validate).thenReturn(true);
      when(() => categoryField.hasError).thenReturn(false);

      when(imageBytesField.validate).thenReturn(true);
      when(() => imageBytesField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when descriptionField hasError', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(descriptionField.validate).thenReturn(false);
      when(() => descriptionField.hasError).thenReturn(true);

      when(priceField.validate).thenReturn(true);
      when(() => priceField.hasError).thenReturn(false);

      when(categoryField.validate).thenReturn(true);
      when(() => categoryField.hasError).thenReturn(false);

      when(imageBytesField.validate).thenReturn(true);
      when(() => imageBytesField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when priceField hasError', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(descriptionField.validate).thenReturn(true);
      when(() => descriptionField.hasError).thenReturn(false);

      when(priceField.validate).thenReturn(false);
      when(() => priceField.hasError).thenReturn(true);

      when(categoryField.validate).thenReturn(true);
      when(() => categoryField.hasError).thenReturn(false);

      when(imageBytesField.validate).thenReturn(true);
      when(() => imageBytesField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when categoryField hasError', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(descriptionField.validate).thenReturn(true);
      when(() => descriptionField.hasError).thenReturn(false);

      when(priceField.validate).thenReturn(true);
      when(() => priceField.hasError).thenReturn(false);

      when(categoryField.validate).thenReturn(false);
      when(() => categoryField.hasError).thenReturn(true);

      when(imageBytesField.validate).thenReturn(true);
      when(() => imageBytesField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when imageBytesField hasError', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(descriptionField.validate).thenReturn(true);
      when(() => descriptionField.hasError).thenReturn(false);

      when(priceField.validate).thenReturn(true);
      when(() => priceField.hasError).thenReturn(false);

      when(categoryField.validate).thenReturn(true);
      when(() => categoryField.hasError).thenReturn(false);

      when(imageBytesField.validate).thenReturn(false);
      when(() => imageBytesField.hasError).thenReturn(true);

      final response = controller.validateFields();

      expect(response, false);
    });
  });

  group('Save products', () {
    test('should create a product with success', () async {
      final name = faker.food.random.string(10);
      final description = faker.food.random.string(10);
      final price = faker.currency.random.decimal(min: 1, scale: 2);

      when(() => nameField.validate()).thenReturn(true);
      when(() => nameField.value).thenReturn(name);
      when(() => nameField.hasError).thenReturn(false);

      when(() => descriptionField.validate()).thenReturn(true);
      when(() => descriptionField.value).thenReturn(description);
      when(() => descriptionField.hasError).thenReturn(false);

      when(() => categoryField.validate()).thenReturn(true);
      when(() => categoryField.value).thenReturn(categoryModel1);
      when(() => categoryField.hasError).thenReturn(false);

      when(() => priceField.validate()).thenReturn(true);
      when(() => priceField.value).thenReturn(price);
      when(() => priceField.hasError).thenReturn(false);

      when(() => imageBytesField.validate()).thenReturn(true);
      when(() => imageBytesField.value).thenReturn(null);
      when(() => imageBytesField.hasError).thenReturn(false);

      final product = ProductModel(
        id: -1,
        name: controller.nameField.value!,
        description: controller.descriptionField.value,
        category: controller.categoryField.value!,
        price: controller.priceField.value!,
      );

      when(() => productRepository.registerProduct(product))
          .thenAnswer((_) async {});

      await controller.saveProduct(backScreen: () {}, onError: (err) {});

      verify(() => productRepository.registerProduct(product));
    });

    test('should update a category with success', () async {
      final name = faker.food.random.string(10);
      final description = faker.food.random.string(10);
      final price = faker.currency.random.decimal(min: 1, scale: 2);

      when(() => nameField.validate()).thenReturn(true);
      when(() => nameField.value).thenReturn(name);
      when(() => nameField.hasError).thenReturn(false);

      when(() => descriptionField.validate()).thenReturn(true);
      when(() => descriptionField.value).thenReturn(description);
      when(() => descriptionField.hasError).thenReturn(false);

      when(() => categoryField.validate()).thenReturn(true);
      when(() => categoryField.value).thenReturn(categoryModel1);
      when(() => categoryField.hasError).thenReturn(false);

      when(() => priceField.validate()).thenReturn(true);
      when(() => priceField.value).thenReturn(price);
      when(() => priceField.hasError).thenReturn(false);

      when(() => imageBytesField.validate()).thenReturn(true);
      when(() => imageBytesField.value).thenReturn(null);
      when(() => imageBytesField.hasError).thenReturn(false);

      final controller = ProductController(
        productRepository: productRepository,
        loading: loading,
        isEdit: true,
        nameField: nameField,
        categoryField: categoryField,
        descriptionField: descriptionField,
        imageBytesField: imageBytesField,
        priceField: priceField,
        product: productModel2,
      );

      final productToSave = ProductModel(
        id: productModel2.id,
        name: controller.nameField.value!,
        category: controller.categoryField.value!,
        price: controller.priceField.value!,
        description: controller.descriptionField.value,
      );

      when(() => productRepository.updateProduct(productToSave))
          .thenAnswer((_) async {});

      await controller.saveProduct(backScreen: () {}, onError: (err) {});

      verify(() => productRepository.updateProduct(productToSave));
    });
  });
}
