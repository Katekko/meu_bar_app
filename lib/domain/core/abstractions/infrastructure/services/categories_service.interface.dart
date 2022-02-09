import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

abstract class ICategoriesService {
  Future<List<CategoryData>> getCategories({String? filter});

  Future<ProductData> getCategoryById(int id);

  Future<void> createCategory(CategoryData body);

  Future<void> updateCategory(CategoryData body);

  Future<void> deleteCategory(CategoryData body);
}
