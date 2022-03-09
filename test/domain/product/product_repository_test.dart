import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/table/product.repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks.dart';
import '../../products.mocks.dart';

void main() {
  late final IProductRepository productRepository;
  late final IProductsService productsService;

  setUpAll(() {
    productsService = ProductsServiceMock();
    productRepository = ProductRepository(
      productsService: productsService,
    );
  });

  group('Get products', () {
    test('should get with success', () async {
      when(
        () => productsService.getProducts(),
      ).thenAnswer((_) async => listProductsData);

      final response = await productRepository.getProducts();

      expect(response, listProductsModel);
    });

    test('should call service with correct filter param', () async {
      const filter = 'filtering';

      when(
        () => productsService.getProducts(filter: filter),
      ).thenAnswer((_) async => listProductsData);

      final response = await productRepository.getProducts(filter: filter);

      expect(response, listProductsModel);
    });

    test('should call service with correct categories param', () async {
      when(
        () => productsService.getProducts(categories: listCategoriesData),
      ).thenAnswer((_) async => listProductsData);

      final response = await productRepository.getProducts(
        categories: listCategoriesModel,
      );

      expect(response, listProductsModel);
    });
  });

  test(
      'Register product should call create product on service with correct param',
      () async {
    when(() => productsService.createProduct(productData1))
        .thenAnswer((_) async {});

    await productRepository.registerProduct(productModel1);

    verify(() => productsService.createProduct(productData1));
  });

  test(
      'Update product should call update product on service with correct param',
      () async {
    when(() => productsService.updateProduct(productData1))
        .thenAnswer((_) async {});

    await productRepository.updateProduct(productModel1);

    verify(() => productsService.updateProduct(productData1));
  });

  test(
      'Delete product should call delete product on service with correct param',
      () async {
    when(() => productsService.deleteProduct(productData1))
        .thenAnswer((_) async {});

    await productRepository.deleteProduct(productModel1);

    verify(() => productsService.deleteProduct(productData1));
  });

  test('Get product by id should call service with correct params', () async {
    const id = 1;

    when(() => productsService.getProductById(id))
        .thenAnswer((_) async => productData1);

    final response = await productRepository.getProductById(id);

    expect(response, productModel1);
  });
}
