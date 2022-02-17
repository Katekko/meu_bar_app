import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/domain/product/product_mock.repository.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late ICategoriesController controller;
  late final IProductRepository productRepository;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
  });

  setUp(() {
    controller = CategoriesController(
      loading: LoadingControllerMock(),
      productRepository: productRepository,
    );
  });

  test('onInit should emit categories to stream', () async {
    when(productRepository.getCategories)
        .thenAnswer((_) async => List.from(listCategoriesModel));

    await controller.onInit();

    verify(() => productRepository.getCategories()).called(1);
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
      when(productRepository.getCategories)
          .thenAnswer((_) async => List.from(listCategoriesModel));

      await controller.loadCategories();

      verify(() => productRepository.getCategories()).called(1);
      expectLater(
        controller.categoriesStream,
        emits(equals(List.from(listCategoriesModel))),
      );
    });

    test('should emit the categories with error', () async {
      final exception = Exception();
      when(productRepository.getCategories).thenThrow(exception);

      await controller.loadCategories();

      verify(() => productRepository.getCategories());
      expectLater(controller.categoriesStream, emitsError(isA<Exception>()));
    });
  });

  test('create category should reload the page (calling again loadCategories)',
      () async {
    when(productRepository.getCategories)
        .thenAnswer((_) async => List.from(listCategoriesModel));

    await controller.createCategory(openScreen: () async {});

    verify(() => productRepository.getCategories()).called(1);

    expectLater(
      controller.categoriesStream,
      emits(equals(List.from(listCategoriesModel))),
    );
  });

  test('edit category should reload the page (calling again loadCategories)',
      () async {
    when(productRepository.getCategories)
        .thenAnswer((_) async => List.from(listCategoriesModel));

    await controller.editCategory(
      openScreen: (_) async {},
      category: categoryModel1,
    );

    verify(() => productRepository.getCategories()).called(1);

    expectLater(
      controller.categoriesStream,
      emits(equals(List.from(listCategoriesModel))),
    );
  });
}
