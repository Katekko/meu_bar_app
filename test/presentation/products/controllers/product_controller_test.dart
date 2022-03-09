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

  late IField<String> nameField;
  late IField<String> descriptionField;
  late IField<double> priceField;
  late IStreamField<CategoryModel?> categoryField;
  late IStreamField<Uint8List?> imageBytesField;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    imagePicker = ImagePickerMock();
    loading = LoadingControllerMock();
  });

  setUp(() {
    nameField = makeProductNameField();
    descriptionField = makeProductDescriptionField();
    priceField = makeProductPriceField();
    categoryField = makeProductCategoryField();
    imageBytesField = makeProductImageBytesField();

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

  group('On Init', () {
    test('should initiate fields when a product is passed', () {
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

      expect(controller.nameField.value, productModel2.name);
      expect(controller.descriptionField.value, productModel2.description);
      expect(controller.priceField.value, productModel2.price);
      expect(controller.categoryField.value, productModel2.category);
      expect(controller.imageBytesField.value, productModel2.imageBytes);
    });

    test('should never initiate fields when a product is not passed', () {
      final controller = ProductController(
        productRepository: productRepository,
        imagePicker: imagePicker,
        loading: loading,
        isEdit: false,
        nameField: nameField,
        categoryField: categoryField,
        descriptionField: descriptionField,
        imageBytesField: imageBytesField,
        priceField: priceField,
      );

      controller.onInit();

      expect(controller.nameField.value, null);
      expect(controller.descriptionField.value, null);
      expect(controller.priceField.value, null);
      expect(controller.categoryField.value, null);
      expect(controller.imageBytesField.value, null);
    });
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
        imageBytes: productModel2.imageBytes,
        urlImage: productModel2.urlImage,
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
