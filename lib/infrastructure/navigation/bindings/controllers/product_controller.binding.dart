import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import '../../../../presentation/products/controllers/controllers.dart';

class ProductControllerBinding extends Bindings {
  final bool isEdit;
  ProductControllerBinding({required this.isEdit});

  @override
  void dependencies() {
    Get.lazyPut<IProductController>(makeProductController);
  }
}

IProductController makeProductController() {
  return ProductController();
}
