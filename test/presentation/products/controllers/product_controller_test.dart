import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late IProductController controller;
  late final IProductRepository productRepository;
  late final IField<String> nameField;
  late final IField<String> descriptionField;
  late final IStreamField<CategoryModel?> categoryField;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    nameField = FieldMock<String>();
    descriptionField = FieldMock<String>();
    categoryField = FieldStreamMock<CategoryModel?>();
  });

  setUp(() {
    controller = ProductController(
      isEdit: false,
      nameField: nameField,
      descriptionField: descriptionField,
      categoryField: categoryField,
    );
  });

  test('Should dipose fields when onClose is called', () async {
    await controller.onClose();

    verify(nameField.dispose).called(1);
    verify(descriptionField.dispose).called(1);
  });

  test('Ensure fields are the same as passed', () {
    expect(controller.nameField, nameField);
    expect(controller.descriptionField, descriptionField);
  });

  group('Validate Fields', () {
    test('should return true', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(descriptionField.validate).thenReturn(true);
      when(() => descriptionField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, true);
    });

    test('should return false when nameField hasError', () {
      when(nameField.validate).thenReturn(false);
      when(() => nameField.hasError).thenReturn(true);

      when(descriptionField.validate).thenReturn(true);
      when(() => descriptionField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, false);
    });

    test('should return false when descriptionField hasError', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      when(descriptionField.validate).thenReturn(false);
      when(() => descriptionField.hasError).thenReturn(true);

      final response = controller.validateFields();

      expect(response, false);
    });
  });
}
