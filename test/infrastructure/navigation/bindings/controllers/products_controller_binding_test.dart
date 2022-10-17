import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:ekko/presentation/products/controllers/controllers.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks.dart';

// TODO: Testar controller de products
void main() {
  late IProductRepository productRepository;
  late ILoadingController loading;

  setUpAll(() {
    productRepository = ProductRepositoryMock();
    loading = LoadingControllerMock();
  });

  test('Should return the correct controller', () {
    final controller = makeProductsController(
      productRepository: productRepository,
      loading: loading,
    );
    expect(controller, isA<ProductsController>());
  });
}
