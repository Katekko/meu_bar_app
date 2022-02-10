import 'package:ekko/infrastructure/navigation/bindings/controllers/home.controller.binding.dart';
import 'package:ekko/presentation/home/controllers/home.controller.dart';
import 'package:test/test.dart';

void main() {
  test('Should return the correct controller', () {
    final controller = makeHomeController();
    expect(controller, isA<HomeController>());
  });
}
