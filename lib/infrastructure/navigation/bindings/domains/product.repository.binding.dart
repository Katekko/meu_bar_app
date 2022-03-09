import '../../../../domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import '../../../../domain/table/product_mock.repository.dart';

class ProductRepositoryBinding {
  late IProductRepository _productRepository;
  IProductRepository get repository => _productRepository;

  ProductRepositoryBinding() {
    _productRepository = ProductMockRepository();
  }
}
