import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../../presentation/categories/controllers/controllers.dart';

class CategoryControllerBinding extends Bindings {
  final bool isEdit;
  CategoryControllerBinding({required this.isEdit});

  @override
  void dependencies() {
    Get.lazyPut<ICategoryController>(
      () => makeCategoryController(isEdit: isEdit),
    );
  }
}

ICategoryController makeCategoryController({required bool isEdit}) {
  return CategoryController(isEdit: isEdit);
}
