import 'package:ekko/domain/product/models/product.model.dart';

abstract class IProductsController {
  Stream<List<ProductModel>> get productsStream;
  bool get productsStreamIsClosed;

  Future<void> loadProducts();

  Future<void> createProduct({required Future<void> Function() openScreen});

  Future<void> editProduct({
    required ProductModel product,
    required Future<void> Function(ProductModel product) openScreen,
  });

  void onReady();
  void onClose();
}
