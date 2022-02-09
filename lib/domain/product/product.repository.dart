import '../core/abstractions/domain/repositories/product_repository.interface.dart';
import '../core/abstractions/infrastructure/services/products_service.interface.dart';
import 'models/category.model.dart';
import 'models/product.model.dart';

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
      final filterCategories = categories?.map((e) => e.toData()).toList();

      final response = await _productsService.getProducts(
        filter: filter,
        categories: filterCategories,
      );

      final models = response.map((e) => ProductModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> registerProduct(ProductModel product) async {
    try {
      final data = product.toData();
      await _productsService.createProduct(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final data = product.toData();
      await _productsService.updateProduct(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(ProductModel product) async {
    try {
      final data = product.toData();
      await _productsService.deleteProduct(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _productsService.getProductById(id);
      final model = ProductModel.fromData(response);
      return model;
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
  Future<void> registerCategory(CategoryModel category) {
    // TODO: implement registerCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(CategoryModel category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
