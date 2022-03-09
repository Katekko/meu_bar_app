import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';

import '../core/abstractions/domain/repositories/category_repository.interface.dart';
import 'models/category.model.dart';

class CategoryRepository implements ICategoryRepository {
  final ICategoriesService _categoriesService;
  const CategoryRepository({
    required ICategoriesService categoriesService,
  }) : _categoriesService = categoriesService;

  @override
  Future<List<CategoryModel>> getCategories({String? filter}) async {
    try {
      final response = await _categoriesService.getCategories(filter: filter);
      final models = response.map((e) => CategoryModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> registerCategory(CategoryModel category) async {
    try {
      final data = category.toData();
      await _categoriesService.createCategory(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    try {
      final data = category.toData();
      await _categoriesService.updateCategory(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(CategoryModel category) async {
    try {
      final data = category.toData();
      await _categoriesService.deleteCategory(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    try {
      final response = await _categoriesService.getCategoryById(id);
      final model = CategoryModel.fromData(response);
      return model;
    } catch (err) {
      rethrow;
    }
  }
}
