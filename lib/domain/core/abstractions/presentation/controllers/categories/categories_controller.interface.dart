import 'package:ekko/domain/product/models/category.model.dart';

abstract class ICategoriesController {
  Stream<List<CategoryModel>> get categories;

  void loadCategories();
}
