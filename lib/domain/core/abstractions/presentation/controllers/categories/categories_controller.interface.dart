import 'package:ekko/domain/product/models/category.model.dart';

abstract class ICategoriesController {
  Stream<List<CategoryModel>> get categoriesStream;
  bool get categoriesStreamIsClosed;

  Future<void> loadCategories();

  Future<void> createCategory({required Future<void> Function() openScreen});

  Future<void> editCategory({
    required CategoryModel category,
    required Future<void> Function(CategoryModel category) openScreen,
  });

  Future<void> onReady();
  void onClose();
}
