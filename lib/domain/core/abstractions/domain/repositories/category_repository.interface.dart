import 'package:ekko/domain/table/models/category.model.dart';

abstract class ICategoryRepository {
  /// Pegar as categorias existentes com a possibilidade de filtrar
  /// usando o atributo [filter]
  Future<List<CategoryModel>> getCategories({String? filter});

  Future<CategoryModel> getCategoryById(int id);

  Future<void> registerCategory(CategoryModel category);

  Future<void> updateCategory(CategoryModel category);

  Future<void> deleteCategory(CategoryModel category);
}
