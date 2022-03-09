import 'package:ekko/domain/product/category.repository.dart';
import 'package:ekko/infrastructure/dal/services/categories/categories.service.dart';

import '../../../../domain/core/abstractions/domain/repositories/category_repository.interface.dart';
import '../../../../domain/core/abstractions/infrastructure/http_connect.interface.dart';
import '../../../dal/inject.dart';

class CategoryRepositoryBinding {
  late ICategoryRepository _categoryRepository;
  ICategoryRepository get repository => _categoryRepository;

  CategoryRepositoryBinding() {
    final connect = Inject.find<IHttpConnect>();
    final categoriesService = CategoriesService(connect);
    _categoryRepository = CategoryRepository(
      categoriesService: categoriesService,
    );
  }
}
