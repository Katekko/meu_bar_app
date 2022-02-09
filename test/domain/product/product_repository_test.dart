import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks.dart';
import '../../products.mocks.dart';

class ProductRepository implements IProductRepository {
  final IProductsService _productsService;
  ProductRepository({required IProductsService productsService})
      : _productsService = productsService;

  @override
  Future<List<ProductModel>> getProducts({
    String? filter,
    List<CategoryModel>? categories,
  }) async {
    try {
      final response = await _productsService.getProducts();
      final models = response.map((e) => ProductModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(CategoryModel category) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(ProductModel product) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategories({String? filter}) {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> getCategoryById(int id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> registerCategory(CategoryModel category) {
    // TODO: implement registerCategory
    throw UnimplementedError();
  }

  @override
  Future<void> registerProduct(ProductModel product) {
    // TODO: implement registerProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(CategoryModel category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}

void main() {
  late final IProductRepository productRepository;
  late final IProductsService productsService;

  setUpAll(() {
    productsService = ProductServiceMock();
    productRepository = ProductRepository(productsService: productsService);
  });

  test('Should get all products with success', () async {
    when(
      () => productsService.getProducts(),
    ).thenAnswer((_) async => listProductsData);

    final response = await productRepository.getProducts();

    expect(response, listProductsModel);
  });
}
