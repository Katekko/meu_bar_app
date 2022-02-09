import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/infrastructure/dal/services/categories/dto/get_categories.response.dart';
import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import '../../../products.mocks.dart';
import 'mocks/categories/get_categories.mock.dart';

class CategoriesService implements ICategoriesService {
  final IHttpConnect _connect;
  const CategoriesService(IHttpConnect connect) : _connect = connect;

  @override
  Future<List<CategoryData>> getCategories({String? filter}) async {
    var url = filter != null ? 'categories?filter=$filter' : 'categories';

    final response = await _connect.get(
      url,
      decoder: GetCategoriesResponse.fromJson,
    );

    if (response.success) {
      return response.payload!.data!;
    } else {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> createCategory(CategoryData body) {
    // TODO: implement createCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(CategoryData body) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<ProductData> getCategoryById(int id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(CategoryData body) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}

void main() {
  late ICategoriesService categoriesService;
  late IHttpConnect connect;

  setUpAll(() {
    connect = ConnectMock();
    categoriesService = CategoriesService(connect);
  });

  group('Get categories', () {
    test(
      'Should get all categories with success',
      () async {
        when(
          () => connect.get('categories', decoder: any(named: 'decoder')),
        ).thenAnswer((_) async => getCategoriesWithSuccessResponse);

        final response = await categoriesService.getCategories();

        expect(response, listCategoriesData);
      },
    );

    // test(
    //   'Should get categories passing filter with success',
    //   () async {
    //     when(
    //       () => connect.get(
    //         'categories?filter=cer',
    //         decoder: any(named: 'decoder'),
    //       ),
    //     ).thenAnswer((_) async => getcategoriesWithSuccessResponse);

    //     final response = await categoriesService.getcategories(filter: 'cer');

    //     expect(response, listcategoriesData);
    //   },
    // );
  });

  // group('Create product', () {
  //   test('with success', () async {
  //     const url = 'categories';

  //     const body = ProductData(
  //       id: -1,
  //       name: 'Petra 600',
  //       price: 12.20,
  //       category: CategoryData(id: 1, name: 'Cerveja'),
  //     );

  //     when(
  //       () => connect.post(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     ).thenAnswer((_) async => createProductWithSuccess);

  //     await categoriesService.createProduct(body);

  //     verify(
  //       () => connect.post(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     );
  //   });

  //   test('should throw DefaultException', () async {
  //     const url = 'categories';

  //     const body = ProductData(
  //       id: -1,
  //       name: 'Petra 600',
  //       price: 12.20,
  //       category: CategoryData(id: 1, name: 'Cerveja'),
  //     );

  //     when(
  //       () => connect.post(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     ).thenAnswer((_) async => createProductWithDefaultError);

  //     final future = categoriesService.createProduct(body);

  //     verify(
  //       () => connect.post(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     );

  //     expect(future, throwsA(isA<DefaultException>()));
  //   });
  // });

  // group('Update product', () {
  //   test('with success', () async {
  //     const url = 'categories';

  //     const body = ProductData(
  //       id: 1,
  //       name: 'Petra 600',
  //       price: 12.20,
  //       category: CategoryData(id: 1, name: 'Cerveja'),
  //     );

  //     when(
  //       () => connect.put(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     ).thenAnswer((_) async => updateProductWithSuccess);

  //     await categoriesService.updateProduct(body);

  //     verify(
  //       () => connect.put(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     );
  //   });

  //   test('should throw DefaultException', () async {
  //     const url = 'categories';

  //     const body = ProductData(
  //       id: 1,
  //       name: 'Petra 600',
  //       price: 12.20,
  //       category: CategoryData(id: 1, name: 'Cerveja'),
  //     );

  //     when(
  //       () => connect.put(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     ).thenAnswer((_) async => updateProductWithDefaultError);

  //     final future = categoriesService.updateProduct(body);

  //     verify(
  //       () => connect.put(
  //         url,
  //         body.toJson(),
  //         decoder: any(named: 'decoder'),
  //       ),
  //     );

  //     expect(future, throwsA(isA<DefaultException>()));
  //   });
  // });

  // group('Delete product', () {
  //   test('with success', () async {
  //     const url = 'categories';

  //     const body = ProductData(
  //       id: 1,
  //       name: 'Petra 600',
  //       price: 12.20,
  //       category: CategoryData(id: 1, name: 'Cerveja'),
  //     );

  //     when(
  //       () => connect.delete(
  //         '$url/${body.id}',
  //         decoder: any(named: 'decoder'),
  //       ),
  //     ).thenAnswer((_) async => deleteProductWithSuccess);

  //     await categoriesService.deleteProduct(body);

  //     verify(
  //       () => connect.delete(
  //         '$url/${body.id}',
  //         decoder: any(named: 'decoder'),
  //       ),
  //     );
  //   });

  //   test('should throw DefaultException', () async {
  //     const url = 'categories';

  //     const body = ProductData(
  //       id: 1,
  //       name: 'Petra 600',
  //       price: 12.20,
  //       category: CategoryData(id: 1, name: 'Cerveja'),
  //     );

  //     when(
  //       () => connect.delete(
  //         '$url/${body.id}',
  //         decoder: any(named: 'decoder'),
  //       ),
  //     ).thenAnswer((_) async => deleteProductWithDefaultError);

  //     final future = categoriesService.deleteProduct(body);

  //     verify(
  //       () => connect.delete(
  //         '$url/${body.id}',
  //         decoder: any(named: 'decoder'),
  //       ),
  //     );

  //     expect(future, throwsA(isA<DefaultException>()));
  //   });
  // });

  // group('Get product by id', () {
  //   test(
  //     'should get with success',
  //     () async {
  //       const id = 1;

  //       when(
  //         () => connect.get('categories/$id', decoder: any(named: 'decoder')),
  //       ).thenAnswer((_) async => getProductByIdWithSuccessResponse);

  //       final response = await categoriesService.getProductById(id);

  //       expect(response, product);
  //     },
  //   );

  //   test(
  //     'should throw nonexistent exception',
  //     () async {
  //       const id = 1;

  //       when(
  //         () => connect.get(
  //           'categories/$id',
  //           decoder: any(named: 'decoder'),
  //         ),
  //       ).thenAnswer((_) async => getProductByIdWithNonexistentError);

  //       final future = categoriesService.getProductById(id);

  //       expect(future, throwsA(isA<NonexistentException>()));
  //     },
  //   );

  //   test(
  //     'should throw default exception',
  //     () async {
  //       const id = 1;

  //       when(
  //         () => connect.get(
  //           'categories/$id',
  //           decoder: any(named: 'decoder'),
  //         ),
  //       ).thenAnswer((_) async => getProductByIdWithUnknowError);

  //       final future = categoriesService.getProductById(id);

  //       expect(future, throwsA(isA<DefaultException>()));
  //     },
  //   );
  // });
}
