import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/infrastructure/dal/services/categories/dto/get_categories.response.dart';
import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import '../../../products.mocks.dart';
import 'mocks/categories/get_categories.mock.dart';
import 'mocks/error_response.mock.dart';

class CategoriesService implements ICategoriesService {
  final IHttpConnect _connect;
  const CategoriesService(IHttpConnect connect) : _connect = connect;

  final _prefix = 'categories';

  @override
  Future<List<CategoryData>> getCategories({String? filter}) async {
    var url = filter != null ? '$_prefix?filter=$filter' : 'categories';

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
  Future<void> createCategory(CategoryData body) async {
    final response = await _connect.post(
      _prefix,
      body.toJson(),
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> updateCategory(CategoryData body) async {
    final response = await _connect.put(
      '$_prefix/${body.id}',
      body.toJson(),
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> deleteCategory(CategoryData body) async {
    final response = await _connect.delete(
      '$_prefix/${body.id}',
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<ProductData> getCategoryById(int id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }
}

void main() {
  late ICategoriesService categoriesService;
  late IHttpConnect connect;

  const urlBase = 'categories';

  setUpAll(() {
    connect = ConnectMock();
    categoriesService = CategoriesService(connect);
  });

  group('Get categories', () {
    test(
      'Should get all categories with success',
      () async {
        when(
          () => connect.get(urlBase, decoder: any(named: 'decoder')),
        ).thenAnswer((_) async => getCategoriesWithSuccessResponse);

        final response = await categoriesService.getCategories();

        expect(response, listCategoriesData);
      },
    );

    test(
      'Should get categories passing filter with success',
      () async {
        when(
          () => connect.get(
            '$urlBase?filter=cer',
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => getCategoriesWithSuccessResponse);

        final response = await categoriesService.getCategories(filter: 'cer');

        expect(response, listCategoriesData);
      },
    );

    test(
      'Should throw default exception',
      () async {
        when(
          () => connect.get('categories', decoder: any(named: 'decoder')),
        ).thenAnswer((_) async => getCategoriesWithUnknowErrorResponse);

        final future = categoriesService.getCategories();

        expect(future, throwsA(isA<DefaultException>()));
      },
    );
  });

  group('Create product', () {
    test('with success', () async {
      when(
        () => connect.post(
          urlBase,
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => responseWithSuccess);

      await categoriesService.createCategory(categoryData1);

      verify(
        () => connect.post(
          urlBase,
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );
    });

    test('should throw DefaultException', () async {
      when(
        () => connect.post(
          urlBase,
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => responseWithUnknowError);

      final future = categoriesService.createCategory(categoryData1);

      verify(
        () => connect.post(
          urlBase,
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<DefaultException>()));
    });
  });

  group('Update product', () {
    test('with success', () async {
      when(
        () => connect.put(
          '$urlBase/${categoryData1.id}',
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => responseWithSuccess);

      await categoriesService.updateCategory(categoryData1);

      verify(
        () => connect.put(
          '$urlBase/${categoryData1.id}',
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );
    });

    test('should throw DefaultException', () async {
      when(
        () => connect.put(
          '$urlBase/${categoryData1.id}',
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => responseWithUnknowError);

      final future = categoriesService.updateCategory(categoryData1);

      verify(
        () => connect.put(
          '$urlBase/${categoryData1.id}',
          categoryData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<DefaultException>()));
    });
  });

  group('Delete product', () {
    test('with success', () async {
      when(
        () => connect.delete(
          '$urlBase/${categoryData1.id}',
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => responseWithSuccess);

      await categoriesService.deleteCategory(categoryData1);

      verify(
        () => connect.delete(
          '$urlBase/${categoryData1.id}',
          decoder: any(named: 'decoder'),
        ),
      );
    });

    test('should throw DefaultException', () async {
      when(
        () => connect.delete(
          '$urlBase/${categoryData1.id}',
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => responseWithUnknowError);

      final future = categoriesService.deleteCategory(categoryData1);

      verify(
        () => connect.delete(
          '$urlBase/${categoryData1.id}',
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<DefaultException>()));
    });
  });

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
