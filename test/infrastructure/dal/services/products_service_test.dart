import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/infrastructure/dal/services/products/products.service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import 'mocks/products_service/get_products.mock.dart';

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
}
