import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/categories/controllers/category.controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late ICategoryController controller;
  late final IProductRepository productRepository;
  late final IField nameField;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    nameField = FieldMock();
  });

  setUp(() {
    controller = CategoryController(
      productRepository: productRepository,
      loading: LoadingControllerMock(),
      isEdit: false,
      nameField: nameField,
    );
  });

  test('should pick correct icon', () {
    controller.pickAnIcon(1);

    expect(controller.iconFieldStream, emits(1));
  });

  test('should create a category with success', () async {
    const name = 'katekko';
    when(() => nameField.validate()).thenReturn(true);
    when(() => nameField.value).thenReturn(name);
    when(() => nameField.hasError).thenReturn(false);

    controller.pickAnIcon(1);
    controller.nameField.value = name;
    final icon = await controller.iconFieldStream.first;
    final category = CategoryModel(
      id: -1,
      name: controller.nameField.value,
      icon: icon!,
    );

    when(() => productRepository.registerCategory(category))
        .thenAnswer((_) async {});

    await controller.saveCategory(backScreen: () {});

    verify(() => productRepository.registerCategory(category));
  });

  test('should update a category with success', () async {
    // arrange
    const name = 'katekko';
    when(() => nameField.validate()).thenReturn(true);
    when(() => nameField.value).thenReturn(name);
    when(() => nameField.hasError).thenReturn(false);

    const category = CategoryModel(id: 1, name: 'Katekko', icon: 1);

    final controller = CategoryController(
      productRepository: productRepository,
      loading: LoadingControllerMock(),
      isEdit: true,
      nameField: nameField,
      category: category,
    );

    controller.pickAnIcon(2);
    final icon = await controller.iconFieldStream.first;
    controller.nameField.value = 'katekko 2';

    final categoryToSave = CategoryModel(
      id: 1,
      name: controller.nameField.value,
      icon: icon!,
    );

    when(() => productRepository.updateCategory(categoryToSave))
        .thenAnswer((_) async {});

    // action
    await controller.saveCategory(backScreen: () {});

    // assert
    verify(() => productRepository.updateCategory(categoryToSave));
  });
}
