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

  test('onInit should emit categories to stream', () {
    when(() => productRepository.getCategories())
        .thenAnswer((_) async => listCategoriesModel);

    controller.onInit();

    verify(() => productRepository.getCategories());
    // TODO: Testar de outro jeito, pois você pode adicionar coisas a+ na lista ou modificar os itens antes de emitir
    expect(controller.categories, emits(listCategoriesModel));
  });
}
