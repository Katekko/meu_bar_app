import 'package:get/get.dart';

import '../../../../domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import '../../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import '../../../../presentation/products/controllers/controllers.dart';
import '../../../../presentation/shared/loading/loading.interface.dart';
import '../../../dal/inject.dart';
import '../domains/product.repository.binding.dart';

class ProductsControllerBinding extends Bindings {
  @override
  void dependencies() {
    final productBinding = ProductRepositoryBinding();
    Inject.put<IProductsController>(
      () => makeProductsController(
        productRepository: productBinding.repository,
        loading: Inject.find<ILoadingController>(),
      ),
    );
  }
}

IProductsController makeProductsController({
  required IProductRepository productRepository,
  required ILoadingController loading,
}) {
  return ProductsController(
    productRepository: productRepository,
    loading: loading,
  );
}
