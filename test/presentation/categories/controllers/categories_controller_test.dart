import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/domain/product/product_mock.repository.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';

void main() {
  late ICategoriesController controller;
  late final IProductRepository productRepository;
  late final BehaviorSubject<List<CategoryModel>> categoriesList;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    categoriesList = CategoriesStreamMock();
  });

  setUp(() {
    controller = CategoriesController(
      loading: LoadingControllerMock(),
      productRepository: productRepository,
      categoriesStream: categoriesList,
    );
  });

  test('onInit should emit categories to stream', () async {
    when(productRepository.getCategories)
        .thenAnswer((_) async => listCategoriesModel);
    when(() => categoriesList.value).thenAnswer((_) => listCategoriesModel);

    await controller.onInit();

    verify(() => productRepository.getCategories());
    // TODO: Precisa verificar se a lista que está sendo passada é igual a lista que veio do repository
    verify(() => categoriesList.add(listCategoriesModel));

    final value = categoriesList.value;
    expect(value, equals(listCategoriesModel));
  });

  test('onClose should dipose all streams and fields', () async {
    when(categoriesList.close).thenAnswer((_) async {});

    controller.onClose();

    verify(() => categoriesList.close());
  });

  test('should emit the categories with success', () async {
    when(productRepository.getCategories)
        .thenAnswer((_) async => listCategoriesModel);

    await controller.loadCategories();

    verify(() => productRepository.getCategories());
    verify(() => categoriesList.add(listCategoriesModel));
  });

  test('should emit the categories with error', () async {
    final exception = Exception();

    when(productRepository.getCategories).thenThrow(exception);
    when(() => categoriesList.addError(exception)).thenAnswer((_) {});

    await controller.loadCategories();

    verify(() => productRepository.getCategories());
    expect(categoriesList, emitsError(isA<Exception>()));
  });
}
