import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct controller', () {
    final controller = makeCategoryController();
    expect(controller, isA<CategoryController>());
  });
}
