import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/infrastructure/navigation/bindings/domains/product.repository.binding.dart';
import 'package:ekko/presentation/categories/controllers/categories.controller.dart';
import 'package:get/get.dart';

class CategoriesControllerBinding extends Bindings {
  @override
  void dependencies() {
    final productBinding = ProductRepositoryBinding();
    Inject.put<ICategoriesController>(
      () => makeCategoriesController(
        productRepository: productBinding.repository,
      ),
    );
  }
}

ICategoriesController makeCategoriesController({
  required IProductRepository productRepository,
}) {
  return CategoriesController(productRepository: productRepository);
}
