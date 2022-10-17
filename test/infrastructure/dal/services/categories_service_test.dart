import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/domain/core/exceptions/nonexistent.exception.dart';
import 'package:ekko/domain/table/models/category.mock.dart';
import 'package:ekko/infrastructure/dal/services/categories/categories.service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';
import 'mocks/categories/get_categories.mock.dart';
import 'mocks/categories/get_category_by_id.mock.dart';
import 'mocks/error_response.mock.dart';

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

  group('Create category', () {
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

  group('Update category', () {
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

  group('Delete category', () {
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

  group('Get product by id', () {
    test(
      'should get with success',
      () async {
        const id = 1;

        when(
          () => connect.get('$urlBase/$id', decoder: any(named: 'decoder')),
        ).thenAnswer((_) async => getCategoryByIdWithSuccessResponse);

        final response = await categoriesService.getCategoryById(id);

        expect(response, categoryData1);
      },
    );

    test(
      'should throw nonexistent exception',
      () async {
        const id = 1;

        when(
          () => connect.get(
            'categories/$id',
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => getCategoryByIdWithNonexistentError);

        final future = categoriesService.getCategoryById(id);

        expect(future, throwsA(isA<NonexistentException>()));
      },
    );

    test(
      'should throw default exception',
      () async {
        const id = 1;

        when(
          () => connect.get(
            'categories/$id',
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => getCategoryByIdUnknowError);

        final future = categoriesService.getCategoryById(id);

        expect(future, throwsA(isA<DefaultException>()));
      },
    );
  });
}
