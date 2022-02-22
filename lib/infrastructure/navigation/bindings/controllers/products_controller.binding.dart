import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import '../../../../presentation/products/controllers/controllers.dart';

class ProductsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IProductsController>(makeProductsController);
  }
}

IProductsController makeProductsController() {
  return ProductsController();
}
