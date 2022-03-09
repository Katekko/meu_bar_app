import 'package:ekko/domain/core/abstractions/domain/repositories/category_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/table/models/category.mock.dart';
import 'package:ekko/domain/table/models/category.model.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/category_controller.binding.dart';
import 'package:ekko/presentation/categories/controllers/category.controller.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late ICategoryController controller;
  late final ICategoryRepository categoryRepository;
  late IField<String> nameField;
  late IStreamField<int?> iconField;

  setUpAll(() {
    categoryRepository = CategoryRepositoryMock();
  });

  setUp(() {
    nameField = makeCategoryNameField();
    iconField = makeCategoryIconField();

    controller = CategoryController(
      categoryRepository: categoryRepository,
      loading: LoadingControllerMock(),
      isEdit: false,
      nameField: nameField,
      iconField: iconField,
    );
  });

  test('pickAnIcon should pick correct icon', () {
    const value = 1;
    controller.iconField.value = value;
    expect(controller.iconField.value, value);
  });

  group('Save Categories', () {
    test('should create a category with success', () async {
      const name = 'katekko';
      const icon = 1;

      controller.iconField.value = icon;
      controller.nameField.value = name;
      final category = CategoryModel(
        id: -1,
        name: controller.nameField.value!,
        icon: controller.iconField.value!,
      );

      when(() => categoryRepository.registerCategory(category))
          .thenAnswer((_) async {});

      await controller.saveCategory(backScreen: () {});

      verify(() => categoryRepository.registerCategory(category));
    });

    test('should update a category with success', () async {
      const name = 'katekko';
      const icon = 1;

      final category = CategoryModel(id: 1, name: name, icon: icon);

      final controller = CategoryController(
        categoryRepository: categoryRepository,
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
        name: controller.nameField.value!,
        icon: controller.iconField.value!,
      );

      when(() => categoryRepository.updateCategory(categoryToSave))
          .thenAnswer((_) async {});

      await controller.saveCategory(backScreen: () {});

      verify(() => categoryRepository.updateCategory(categoryToSave));
    });
  });

  group('Validate Fields', () {
    test('should return true', () {
      final faker = Faker();
      controller.nameField.value = faker.job.random.string(5);
      controller.iconField.value = faker.randomGenerator.integer(5);

      final response = controller.validateFields();

      expect(response, true);
    });

    test('should return false when icon is null', () {
      controller.nameField.value = 'Category';
      controller.iconField.value = null;

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when nameField is invalid', () {
      controller.nameField.value = null;
      controller.iconField.value = 32;

      final response = controller.validateFields();

      expect(response, false);
    });
  });

  group('On Init', () {
    test('should initiate fields when a category is passed', () {
      final controller = CategoryController(
        categoryRepository: categoryRepository,
        loading: LoadingControllerMock(),
        isEdit: false,
        nameField: nameField,
        iconField: iconField,
        category: categoryModel1,
      );

      controller.onInit();

      expect(nameField.value, categoryModel1.name);
      expect(iconField.value, categoryModel1.icon);
    });

    test('should never initiate fields when a category is not passed', () {
      final controller = CategoryController(
        categoryRepository: categoryRepository,
        loading: LoadingControllerMock(),
        isEdit: false,
        nameField: nameField,
        iconField: iconField,
      );

      controller.onInit();

      expect(nameField.value, null);
      expect(iconField.value, null);
    });
  });
}
