import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/presentation/categories/controllers/category.controller.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  // TODO: Conseguir testar as streams
  // ignore: unused_local_variable
  late ICategoryController controller;
  late final IProductRepository productRepository;
  late final IField<String> nameField;
  late final FieldStreamMock<int?> iconField;

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

  // test('pickAnIcon should pick correct icon', () {
  //   when(controller.iconField.validate).thenReturn(true);
  //   when(() => controller.iconField.stream)
  //       .thenAnswer((_) => BehaviorSubject());

  //   controller.pickAnIcon(1);
  //   controller.iconField.validate();

  //   expect(controller.iconField.stream, emits(1));
  //   expect(controller.iconField.value, 1);
  //   expect(controller.iconField.hasError, false);
  // });

  // group('Save Categories', () {
  //   test('should create a category with success', () async {
  //     const name = 'katekko';
  //     when(() => nameField.validate()).thenReturn(true);
  //     when(() => nameField.value).thenReturn(name);
  //     when(() => nameField.hasError).thenReturn(false);

  //     controller.pickAnIcon(1);
  //     controller.nameField.value = name;
  //     final category = CategoryModel(
  //       id: -1,
  //       name: controller.nameField.value,
  //       icon: controller.iconField.value!,
  //     );

  //     when(() => productRepository.registerCategory(category))
  //         .thenAnswer((_) async {});

  //     await controller.saveCategory(backScreen: () {});

  //     verify(() => productRepository.registerCategory(category));
  //   });

  //   test('should update a category with success', () async {
  //     // arrange
  //     const name = 'katekko';
  //     when(() => nameField.validate()).thenReturn(true);
  //     when(() => nameField.value).thenReturn(name);
  //     when(() => nameField.hasError).thenReturn(false);

  //     const category = CategoryModel(id: 1, name: 'Katekko', icon: 1);

  //     final controller = CategoryController(
  //       productRepository: productRepository,
  //       loading: LoadingControllerMock(),
  //       isEdit: true,
  //       nameField: nameField,
  //       iconField: iconField,
  //       category: category,
  //     );

  //     controller.pickAnIcon(2);
  //     controller.nameField.value = 'katekko 2';

  //     final categoryToSave = CategoryModel(
  //       id: 1,
  //       name: controller.nameField.value,
  //       icon: controller.iconField.value!,
  //     );

  //     when(() => productRepository.updateCategory(categoryToSave))
  //         .thenAnswer((_) async {});

  //     // action
  //     await controller.saveCategory(backScreen: () {});

  //     // assert
  //     verify(() => productRepository.updateCategory(categoryToSave));
  //   });
  // });

  // group('Validate Fields', () {
  //   test('should return true', () {
  //     when(nameField.validate).thenReturn(true);
  //     when(() => nameField.hasError).thenReturn(false);
  //     controller.pickAnIcon(1);

  //     final response = controller.validateFields();

  //     expect(response, true);
  //   });

  //   test('should return false when icon is null', () {
  //     when(nameField.validate).thenReturn(true);
  //     when(() => nameField.hasError).thenReturn(false);

  //     final response = controller.validateFields();

  //     expect(response, false);
  //   });

  //   test('should return false when validate field return false', () {
  //     when(nameField.validate).thenReturn(false);
  //     when(() => nameField.hasError).thenReturn(true);

  //     final response = controller.validateFields();

  //     expect(response, false);
  //   });
  // });

  // test('description', () {
  //   controller.onClose();

  //   verify(nameField.dispose);
  //   verify(iconField.dispose);
  // });
}
