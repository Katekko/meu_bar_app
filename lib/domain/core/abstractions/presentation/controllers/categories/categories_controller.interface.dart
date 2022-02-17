import 'package:ekko/domain/product/models/category.model.dart';

abstract class ICategoriesController {
  Stream<List<CategoryModel>> get categoriesStream;
  bool get categoriesStreamIsClosed;

  Future<void> loadCategories();

  void createCategory({required Future<void> Function() openScreen});

  void editCategory({
    required CategoryModel category,
    required Future<void> Function(CategoryModel category) openScreen,
  });

  Future<void> onInit();
  void onClose();
}
