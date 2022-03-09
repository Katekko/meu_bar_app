import 'package:ekko/domain/table/category.repository.dart';
import 'package:ekko/infrastructure/dal/services/categories/categories_mock.service.dart';

import '../../../../domain/core/abstractions/domain/repositories/category_repository.interface.dart';

class CategoryRepositoryBinding {
  late ICategoryRepository _categoryRepository;
  ICategoryRepository get repository => _categoryRepository;

  CategoryRepositoryBinding() {
    final categoriesServiceMock = CategoriesMockService();
    _categoryRepository = CategoryRepository(
      categoriesService: categoriesServiceMock,
    );
  }
}
