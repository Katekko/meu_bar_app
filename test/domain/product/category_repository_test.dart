import 'package:ekko/domain/core/abstractions/domain/repositories/category_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';
import 'package:ekko/domain/product/category.repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks.dart';
import '../../products.mocks.dart';

void main() {
  late final ICategoryRepository categoryRepository;
  late final ICategoriesService categoriesService;

  setUpAll(() {
    categoriesService = CategoriesServiceMock();
    categoryRepository = CategoryRepository(
      categoriesService: categoriesService,
    );
  });

  group('Get categories', () {
    test('should get with success', () async {
      when(
        () => categoriesService.getCategories(),
      ).thenAnswer((_) async => listCategoriesData);

      final response = await categoryRepository.getCategories();

      expect(response, listCategoriesModel);
    });

    test('should call service with correct filter param', () async {
      const filter = 'filtering';

      when(
        () => categoriesService.getCategories(filter: filter),
      ).thenAnswer((_) async => listCategoriesData);

      final response = await categoryRepository.getCategories(filter: filter);

      expect(response, listCategoriesModel);
    });
  });

  test(
      'Register category should call create category on service with correct param',
      () async {
    when(() => categoriesService.createCategory(categoryData1))
        .thenAnswer((_) async {});

    await categoryRepository.registerCategory(categoryModel1);

    verify(() => categoriesService.createCategory(categoryData1));
  });

  test(
      'Update category should call update category on service with correct param',
      () async {
    when(() => categoriesService.updateCategory(categoryData1))
        .thenAnswer((_) async {});

    await categoryRepository.updateCategory(categoryModel1);

    verify(() => categoriesService.updateCategory(categoryData1));
  });

  test(
      'Delete category should call delete category on service with correct param',
      () async {
    when(() => categoriesService.deleteCategory(categoryData1))
        .thenAnswer((_) async {});

    await categoryRepository.deleteCategory(categoryModel1);

    verify(() => categoriesService.deleteCategory(categoryData1));
  });

  test('Get category by id should call service with correct params', () async {
    const id = 1;

    when(() => categoriesService.getCategoryById(id))
        .thenAnswer((_) async => categoryData1);

    final response = await categoryRepository.getCategoryById(id);

    expect(response, categoryModel1);
  });
}
