import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct controller with isEdit true', () {
    final controller = makeCategoryController(isEdit: true);
    expect(controller, isA<CategoryController>());
    expect(controller.isEdit, true);
  });

  test('Should return the correct controller with isEdit false', () {
    final controller = makeCategoryController(isEdit: false);
    expect(controller, isA<CategoryController>());
    expect(controller.isEdit, false);
  });
}
