import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/presentation/categories/controllers/categories.controller.dart';
import 'package:get/get.dart';

class CategoriesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Inject.put<ICategoriesController>(
      () => makeCategoriesController(),
    );
  }
}

ICategoriesController makeCategoriesController() {
  return CategoriesController();
}
