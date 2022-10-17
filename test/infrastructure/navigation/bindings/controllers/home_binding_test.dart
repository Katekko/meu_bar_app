import 'package:ekko/infrastructure/navigation/bindings/controllers/home.controller.binding.dart';
import 'package:ekko/presentation/home/controllers/home.controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the correct controller', () {
    final controller = makeHomeController();
    expect(controller, isA<HomeController>());
  });
}
