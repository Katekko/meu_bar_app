import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';
import 'package:ekko/domain/table/models/Category.mock.dart';
import 'package:ekko/infrastructure/dal/services/data/category.data.dart';

import '../data/category.data.dart';

class CategoriesMockService implements ICategoriesService {
  @override
  Future<List<CategoryData>> getCategories({
    String? filter,
    List<CategoryData>? categories,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listCategoriesData;
  }

  @override
  Future<void> createCategory(CategoryData body) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listCategoriesData.add(body);
  }

  @override
  Future<void> updateCategory(CategoryData body) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final index = listCategoriesData.indexWhere((e) => e.id == body.id);
    listCategoriesData[index] = body;
  }

  @override
  Future<void> deleteCategory(CategoryData body) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listCategoriesData.removeWhere((e) => body.id == e.id);
  }

  @override
  Future<CategoryData> getCategoryById(int id) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listCategoriesData.firstWhere((e) => e.id == id);
  }
}
