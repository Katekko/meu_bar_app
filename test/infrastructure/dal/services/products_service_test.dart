import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:ekko/infrastructure/dal/services/products/products.service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import 'mocks/products_service/create_product.mock.dart';
import 'mocks/products_service/get_products.mock.dart';
import 'mocks/products_service/update_product.mock.dart';

void main() {
  late IProductsService productsService;
  late IHttpConnect connect;

  setUpAll(() {
    connect = ConnectMock();
    productsService = ProductsService(connect);
  });

  group('Get products', () {
    test(
      'Should get all products with success',
      () async {
        when(
          () => connect.get('products', decoder: any(named: 'decoder')),
        ).thenAnswer((_) async => getProductsWithSuccessResponse);

        final response = await productsService.getProducts();

        expect(response, listProducts);
      },
    );

    test(
      'Should get products passing filter with success',
      () async {
        when(
          () => connect.get(
            'products?filter=cer',
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => getProductsWithSuccessResponse);

        final response = await productsService.getProducts(filter: 'cer');

        expect(response, listProducts);
      },
    );
  });

  group('Create product', () {
    test('with success', () async {
      const url = 'products';

      const body = ProductData(
        id: -1,
        name: 'Petra 600',
        value: 12.20,
        category: CategoryData(id: 1, name: 'Cerveja'),
      );

      when(
        () => connect.post(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => createProductWithSuccess);

      await productsService.createProduct(body);

      verify(
        () => connect.post(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );
    });

    test('should throw DefaultException', () async {
      const url = 'products';

      const body = ProductData(
        id: -1,
        name: 'Petra 600',
        value: 12.20,
        category: CategoryData(id: 1, name: 'Cerveja'),
      );

      when(
        () => connect.post(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => createProductWithDefaultError);

      final future = productsService.createProduct(body);

      verify(
        () => connect.post(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<DefaultException>()));
    });
  });

  group('Update product', () {
    test('with success', () async {
      const url = 'products';

      const body = ProductData(
        id: 1,
        name: 'Petra 600',
        value: 12.20,
        category: CategoryData(id: 1, name: 'Cerveja'),
      );

      when(
        () => connect.put(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => updateProductWithSuccess);

      await productsService.updateProduct(body);

      verify(
        () => connect.put(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );
    });

    test('should throw DefaultException', () async {
      const url = 'products';

      const body = ProductData(
        id: 1,
        name: 'Petra 600',
        value: 12.20,
        category: CategoryData(id: 1, name: 'Cerveja'),
      );

      when(
        () => connect.put(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => updateProductWithDefaultError);

      final future = productsService.updateProduct(body);

      verify(
        () => connect.put(
          url,
          body.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<DefaultException>()));
    });
  });
}
