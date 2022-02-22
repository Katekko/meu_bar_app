import 'package:ekko/domain/product/models/product.model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import '../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import '../../shared/loading/loading.interface.dart';

class ProductsController extends GetxController implements IProductsController {
  final IProductRepository _productRepository;
  final ILoadingController _loading;

  ProductsController({
    required IProductRepository productRepository,
    required ILoadingController loading,
  })  : _productRepository = productRepository,
        _loading = loading;

  final _productsStream = BehaviorSubject<List<ProductModel>>();

  @override
  Stream<List<ProductModel>> get productsStream => _productsStream.stream;

  @override
  bool get productsStreamIsClosed => _productsStream.isClosed;

  @override
  void onReady() {
    super.onReady();
    loadProducts();
  }

  @override
  void onClose() {
    _productsStream.close();
    super.onClose();
  }

  @override
  Future<void> loadProducts() async {
    try {
      _loading.isLoading = true;
      final response = await _productRepository.getProducts();
      _productsStream.add(response);
    } catch (err) {
      _productsStream.addError(err);
    } finally {
      _loading.isLoading = false;
    }
  }

  @override
  Future<void> createProduct({
    required Future<void> Function() openScreen,
  }) async {
    await openScreen();
    loadProducts();
  }

  @override
  Future<void> editProduct({
    required ProductModel product,
    required Future<void> Function(ProductModel product) openScreen,
  }) async {
    await openScreen(product);
    loadProducts();
  }
}
