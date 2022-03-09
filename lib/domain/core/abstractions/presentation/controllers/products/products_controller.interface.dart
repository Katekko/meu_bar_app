import 'package:ekko/domain/table/models/product.model.dart';

abstract class IProductsController {
  Stream<List<ProductModel>> get productsStream;
  bool get productsStreamIsClosed;

  Future<void> loadProducts();

  Future<void> createProduct({required Future<void> Function() openScreen});

  Future<void> editProduct({
    required ProductModel product,
    required Future<void> Function(ProductModel product) openScreen,
  });

  Future<void> onReady();
  void onClose();
}
