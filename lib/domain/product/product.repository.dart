import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';

import '../core/abstractions/domain/repositories/product_repository.interface.dart';
import '../core/abstractions/infrastructure/services/products_service.interface.dart';
import 'models/category.model.dart';
import 'models/product.model.dart';

class ProductRepository implements IProductRepository {
  final IProductsService _productsService;
  final ICategoriesService _categoriesService;
  const ProductRepository({
    required IProductsService productsService,
    required ICategoriesService categoriesService,
  })  : _productsService = productsService,
        _categoriesService = categoriesService;

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
  Future<List<CategoryModel>> getCategories({String? filter}) async {
    try {
      final response = await _categoriesService.getCategories(filter: filter);
      final models = response.map((e) => CategoryModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> registerCategory(CategoryModel category) async {
    try {
      final data = category.toData();
      await _categoriesService.createCategory(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    try {
      final data = category.toData();
      await _categoriesService.updateCategory(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(CategoryModel category) async {
    try {
      final data = category.toData();
      await _categoriesService.deleteCategory(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    try {
      final response = await _categoriesService.getCategoryById(id);
      final model = CategoryModel.fromData(response);
      return model;
    } catch (err) {
      rethrow;
    }
  }
}
