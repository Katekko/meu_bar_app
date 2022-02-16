import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/models/getx_field.model.dart';
import 'package:ekko/domain/product/product_mock.repository.dart';
import 'package:ekko/presentation/categories/controllers/category.controller.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late final ICategoryController controller;

  setUpAll(() {
    controller = CategoryController(
      productRepository: ProductMockRepository(),
      loading: LoadingControllerMock(),
      isEdit: false,
      nameField: FieldMock(value: ''),
    );
  });

  test('should pick correct icon', () {
    controller.pickAnIcon(1);

    expect(controller.iconFieldStream, emits(1));
  });
}
