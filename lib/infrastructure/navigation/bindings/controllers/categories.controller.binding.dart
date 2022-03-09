import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/presentation/categories/controllers/categories.controller.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

import '../../../../domain/core/abstractions/domain/repositories/category_repository.interface.dart';
import '../domains/category.repository.binding.dart';

class CategoriesControllerBinding extends Bindings {
  @override
  void dependencies() {
    final categoryBinding = CategoryRepositoryBinding();
    Inject.lazyPut<ICategoriesController>(
      () => makeCategoriesController(
        categoryRepository: categoryBinding.repository,
        loading: Inject.find<ILoadingController>(),
      ),
    );
  }
}

ICategoriesController makeCategoriesController({
  required ICategoryRepository categoryRepository,
  required ILoadingController loading,
}) {
  return CategoriesController(
    categoryRepository: categoryRepository,
    loading: loading,
  );
}
