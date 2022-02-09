import 'package:ekko/infrastructure/dal/services/data/category.data.dart';

abstract class ICategoriesService {
  Future<List<CategoryData>> getCategories({String? filter});

  Future<CategoryData> getCategoryById(int id);

  Future<void> createCategory(CategoryData body);

  Future<void> updateCategory(CategoryData body);

  Future<void> deleteCategory(CategoryData body);
}
