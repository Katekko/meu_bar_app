import 'package:ekko/domain/product/models/category.model.dart';

abstract class ICategoriesController {
  Stream<List<CategoryModel>> get categories;

  void loadCategories();
  void editCategory({
    required CategoryModel category,
    required void Function(CategoryModel category) openScreen,
  });
}
