import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import 'package:ekko/domain/table/models/product.mock.dart';
import 'package:ekko/presentation/controllers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';

void main() {
  late IProductsController controller;
  late final IProductRepository productRepository;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
  });

  setUp(() {
    controller = ProductsController(
      loading: LoadingControllerMock(),
      productRepository: productRepository,
    );
  });

  test('onReady should emit products to stream', () async {
    when(productRepository.getProducts)
        .thenAnswer((_) async => List.from(listProductsModel));

    await controller.onReady();

    verify(productRepository.getProducts).called(1);
    expectLater(
      controller.productsStream,
      emits(equals(List.from(listProductsModel))),
    );
  });

  test('onClose should dipose all streams and fields', () async {
    controller.onClose();

    expect(controller.productsStreamIsClosed, true);
  });

  group('loadProducts', () {
    test('should emit the products with success', () async {
      when(productRepository.getProducts)
          .thenAnswer((_) async => List.from(listProductsModel));

      await controller.loadProducts();

      verify(productRepository.getProducts).called(1);
      expectLater(
        controller.productsStream,
        emits(equals(List.from(listProductsModel))),
      );
    });

    test('should emit the products stream with error', () async {
      final exception = Exception();
      when(productRepository.getProducts).thenThrow(exception);

      await controller.loadProducts();

      verify(productRepository.getProducts).called(1);
      expectLater(controller.productsStream, emitsError(isA<Exception>()));
    });
  });

  test('create product should reload the page (calling again loadProducts)',
      () async {
    when(productRepository.getProducts)
        .thenAnswer((_) async => List.from(listProductsModel));

    await controller.createProduct(openScreen: () async {});

    verify(productRepository.getProducts).called(1);
    expectLater(
      controller.productsStream,
      emits(equals(List.from(listProductsModel))),
    );
  });

  test('edit product should reload the page (calling again loadProducts)',
      () async {
    when(productRepository.getProducts)
        .thenAnswer((_) async => List.from(listProductsModel));

    await controller.editProduct(
      openScreen: (_) async {},
      product: productModel1,
    );

    verify(productRepository.getProducts).called(1);
    expectLater(
      controller.productsStream,
      emits(equals(List.from(listProductsModel))),
    );
  });
}
