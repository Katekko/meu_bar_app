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
      controller.categories,
      emits(equals(List.from(listCategoriesModel))),
    );
  });

  test('onClose should dipose all streams and fields', () async {
    controller.onClose();
  });

  // test('should emit the categories with success', () async {
  //   when(productRepository.getCategories)
  //       .thenAnswer((_) async => listCategoriesModel);

  //   await controller.loadCategories();

  //   verify(() => productRepository.getCategories());
  //   verify(() => categoriesList.add(listCategoriesModel));
  // });

  // test('should emit the categories with error', () async {
  //   final exception = Exception();

  //   when(productRepository.getCategories).thenThrow(exception);
  //   when(() => categoriesList.addError(exception)).thenAnswer((_) {});

  //   await controller.loadCategories();

  //   verify(() => productRepository.getCategories());
  //   expect(categoriesList, emitsError(isA<Exception>()));
  // });
}
