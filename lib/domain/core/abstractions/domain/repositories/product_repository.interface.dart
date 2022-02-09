import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/domain/product/models/product.model.dart';

abstract class IProductRepository {
  /// Pegar os produtos existentes com a possibilidade de filtrar
  /// pelas categorias usando o atributo [categories] ou [filter]
  Future<List<ProductModel>> getProducts({
    String? filter,
    List<CategoryModel>? categories,
  });

  Future<ProductModel> getProductById(int id);

  Future<void> registerProduct(ProductModel product);

  Future<void> updateProduct(ProductModel product);

  Future<void> deleteProduct(ProductModel product);

  /// Pegar as categorias existentes com a possibilidade de filtrar
  /// usando o atributo [filter]
  Future<List<CategoryModel>> getCategories({String? filter});

  Future<CategoryModel> getCategoryById(int id);

  Future<void> registerCategory(CategoryModel category);

  Future<void> updateCategory(CategoryModel category);

  Future<void> deleteCategory(CategoryModel category);
}
