import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

abstract class IProductsService {
  Future<List<ProductData>> getProducts({
    String? filter,
    List<CategoryData>? categories,
  });

  Future<ProductData> getProductById(int id);

  Future<void> createProduct(ProductData body);

  Future<void> updateProduct(ProductData body);

  Future<void> deleteProduct(ProductData body);
}
