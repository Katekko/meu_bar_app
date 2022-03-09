import 'package:ekko/domain/core/abstractions/domain/repositories/category_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/domain/table/product_mock.repository.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late ICategoriesController controller;
  late final ICategoryRepository categoryRepository;

  setUpAll(() {
    categoryRepository = CategoryRepositoryMock();
  });

  setUp(() {
    controller = CategoriesController(
      loading: LoadingControllerMock(),
      categoryRepository: categoryRepository,
    );
  });

  test('onInit should emit categories to stream', () async {
    when(categoryRepository.getCategories)
        .thenAnswer((_) async => List.from(listCategoriesModel));

    await controller.onReady();

    verify(() => categoryRepository.getCategories()).called(1);
    expectLater(
      controller.categoriesStream,
      emits(equals(List.from(listCategoriesModel))),
    );
  });

  test('onClose should dipose all streams and fields', () async {
    controller.onClose();

    expect(controller.categoriesStreamIsClosed, true);
  });

  group('loadCategories', () {
    test('should emit the categories with success', () async {
      when(categoryRepository.getCategories)
          .thenAnswer((_) async => List.from(listCategoriesModel));

      await controller.loadCategories();

      verify(() => categoryRepository.getCategories()).called(1);
      expectLater(
        controller.categoriesStream,
        emits(equals(List.from(listCategoriesModel))),
      );
    });

    test('should emit the categories with error', () async {
      final exception = Exception();
      when(categoryRepository.getCategories).thenThrow(exception);

      await controller.loadCategories();

      verify(() => categoryRepository.getCategories());
      expectLater(controller.categoriesStream, emitsError(isA<Exception>()));
    });
  });

  test('create category should reload the page (calling again loadCategories)',
      () async {
    when(categoryRepository.getCategories)
        .thenAnswer((_) async => List.from(listCategoriesModel));

    await controller.createCategory(openScreen: () async {});

    verify(() => categoryRepository.getCategories()).called(1);

    expectLater(
      controller.categoriesStream,
      emits(equals(List.from(listCategoriesModel))),
    );
  });

  test('edit category should reload the page (calling again loadCategories)',
      () async {
    when(categoryRepository.getCategories)
        .thenAnswer((_) async => List.from(listCategoriesModel));

    await controller.editCategory(
      openScreen: (_) async {},
      category: categoryModel1,
    );

    verify(() => categoryRepository.getCategories()).called(1);

    expectLater(
      controller.categoriesStream,
      emits(equals(List.from(listCategoriesModel))),
    );
  });
}
