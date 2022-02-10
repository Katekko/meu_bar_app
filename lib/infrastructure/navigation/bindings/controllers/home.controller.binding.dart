import 'package:ekko/domain/core/abstractions/presentation/controllers/home/home_controller.interface.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/presentation/home/controllers/home.controller.dart';
import 'package:get/get.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Inject.put<IHomeController>(
      () => makeHomeController(),
    );
  }
}

IHomeController makeHomeController() {
  return HomeController();
}
