import 'dart:typed_data';

import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/image_picker.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/domain/product/product_mock.repository.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late IProductController controller;

  late final IProductRepository productRepository;
  late final IImagePicker imagePicker;
  late final ILoadingController loading;

  late final IField<String> nameField;
  late final IField<String> descriptionField;
  late final IField<double> priceField;
  late final IStreamField<CategoryModel?> categoryField;
  late final IStreamField<Uint8List?> imageBytesField;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    imagePicker = ImagePickerMock();
    loading = LoadingControllerMock();

    nameField = makeProductNameField();
    descriptionField = makeProductDescriptionField();
    priceField = makeProductPriceField();
    categoryField = makeProductCategoryField();
    imageBytesField = makeProductImageBytesField();
  });

  setUp(() {
    controller = ProductController(
      productRepository: productRepository,
      imagePicker: imagePicker,
      loading: loading,
      isEdit: false,
      nameField: nameField,
      descriptionField: descriptionField,
      categoryField: categoryField,
      priceField: priceField,
      imageBytesField: imageBytesField,
    );
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
      nameField.value = 'Produto 1';
      priceField.value = 2.55;
      categoryField.value = categoryModel1;

      final response = controller.validateFields();

      expect(response, true);
    });

    test('should return false when nameField hasError', () {
      nameField.value = null;
      priceField.value = 2.55;
      categoryField.value = categoryModel1;

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when priceField hasError', () {
      nameField.value = 'Produto 1';
      priceField.value = null;
      categoryField.value = categoryModel1;

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when categoryField hasError', () {
      nameField.value = 'Produto 1';
      priceField.value = 2.55;
      categoryField.value = null;

      final response = controller.validateFields();

      expect(response, false);
    });
  });

  group('Save products', () {
    test('should create a product with success', () async {
      final name = faker.food.random.string(10);
      final description = faker.food.random.string(10);
      final price = faker.currency.random.decimal(min: 1, scale: 2);

      controller.nameField.value = name;
      controller.descriptionField.value = description;
      controller.priceField.value = price;
      controller.categoryField.value = categoryModel1;

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
      final price = faker.currency.random.decimal(min: 1, scale: 2);

      final controller = ProductController(
        productRepository: productRepository,
        imagePicker: imagePicker,
        loading: loading,
        isEdit: true,
        nameField: nameField,
        categoryField: categoryField,
        descriptionField: descriptionField,
        imageBytesField: imageBytesField,
        priceField: priceField,
        product: productModel2,
      );

      controller.onInit();

      controller.nameField.value = name;
      controller.priceField.value = price;

      final productToSave = ProductModel(
        id: productModel2.id,
        name: controller.nameField.value!,
        category: productModel2.category,
        price: controller.priceField.value!,
        description: productModel2.description,
      );

      when(() => productRepository.updateProduct(productToSave))
          .thenAnswer((_) async {});

      await controller.saveProduct(backScreen: () {}, onError: (err) {});

      verify(() => productRepository.updateProduct(productToSave));
    });
  });

  test('Should pick image with success', () async {
    final bytes = Uint8List(1);
    when(imagePicker.pickCameraImage).thenAnswer((_) async => bytes);

    await controller.pickImage();

    expect(controller.imageBytesField.value, bytes);
  });
}
