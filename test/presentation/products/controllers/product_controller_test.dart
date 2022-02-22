import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late IProductController controller;
  late final IProductRepository productRepository;
  late final IField<String> nameField;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    nameField = FieldMock<String>();
  });

  setUp(() {
    controller = ProductController(
      nameField: nameField,
    );
  });

  test('Should dipose fields when onClose is called', () async {
    await controller.onClose();

    verify(nameField.dispose).called(1);
  });

  group('Validate Fields', () {
    test('should return true', () {
      when(nameField.validate).thenReturn(true);
      when(() => nameField.hasError).thenReturn(false);

      final response = controller.validateFields();

      expect(response, true);
    });

    test('should return false when nameField hasError', () {
      when(nameField.validate).thenReturn(false);
      when(() => nameField.hasError).thenReturn(true);

      final response = controller.validateFields();

      expect(response, false);
    });
  });
}
