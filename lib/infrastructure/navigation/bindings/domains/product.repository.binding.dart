import 'package:ekko/domain/table/product.repository.dart';
import 'package:ekko/infrastructure/dal/services/products/products_mock.service.dart';

import '../../../../domain/core/abstractions/domain/repositories/product_repository.interface.dart';

class ProductRepositoryBinding {
  late IProductRepository _productRepository;
  IProductRepository get repository => _productRepository;

  ProductRepositoryBinding() {
    final productsServiceMock = ProductsMockService();
    _productRepository = ProductRepository(
      productsService: productsServiceMock,
    );
  }
}
