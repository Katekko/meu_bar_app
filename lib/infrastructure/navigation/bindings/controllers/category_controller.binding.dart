import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../../presentation/categories/controllers/controllers.dart';

class CategoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ICategoryController>(makeCategoryController);
  }
}

ICategoryController makeCategoryController() {
  return CategoryController();
}
