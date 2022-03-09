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
}
