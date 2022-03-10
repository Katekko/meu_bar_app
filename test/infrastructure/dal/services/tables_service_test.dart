import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/table_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/domain/core/exceptions/table_name_already_exists.exception.dart';
import 'package:ekko/domain/table/models/table.mock.dart';
import 'package:ekko/infrastructure/dal/services/tables/tables.service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import 'mocks/tables_service/get_tables.mock.dart';
import 'mocks/tables_service/post_table.mock.dart';
import 'mocks/tables_service/put_table.mock.dart';

void main() {
  late ITablesService tablesService;
  late IHttpConnect connect;

  const urlBase = 'tables';

  setUpAll(() {
    connect = ConnectMock();
    tablesService = TablesService(connect);
  });

  group('Get tables', () {
    test(
      'Should get all tables with success',
      () async {
        when(() => connect.get(urlBase, decoder: any(named: 'decoder')))
            .thenAnswer(
          (_) async => getTablesWithSuccessResponse,
        );

        final response = await tablesService.getTables();

        expect(response, getTablesWithSuccessResponse.payload!.data);
      },
    );

    test(
      'Should throw default exception when erorr',
      () async {
        when(() => connect.get(urlBase, decoder: any(named: 'decoder')))
            .thenAnswer(
          (_) async => getTablesWithDefaultExceptionResponse,
        );

        final future = tablesService.getTables();

        expect(
          future,
          throwsA(
            equals(
              DefaultException(
                message: getTablesWithDefaultExceptionResponse
                    .payload!.errors!.first.desc,
              ),
            ),
          ),
        );
      },
    );
  });

  group('Create category', () {
    test('with success', () async {
      when(
        () => connect.post(
          urlBase,
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => postTableWithSuccessResponse);

      await tablesService.postTable(tableData1);

      verify(
        () => connect.post(
          urlBase,
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );
    });
    test('should throw TableNameAlreadyUsedException', () async {
      when(
        () => connect.post(
          urlBase,
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => postTableWithNameAlreadyUsedExceptionResponse);

      final future = tablesService.postTable(tableData1);

      verify(
        () => connect.post(
          urlBase,
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<TableNameAlreadyExistsException>()));
    });

    test('should throw DefaultException', () async {
      when(
        () => connect.post(
          urlBase,
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => postTableWithDefaultExceptionResponse);

      final future = tablesService.postTable(tableData1);

      verify(
        () => connect.post(
          urlBase,
          tableData1.toJson(),
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
          '$urlBase/${tableData1.id}',
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => putTableWithSuccessResponse);

      await tablesService.putTable(tableData1);

      verify(
        () => connect.put(
          '$urlBase/${tableData1.id}',
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );
    });

    test('should throw TableNameAlreadyUsedException', () async {
      when(
        () => connect.put(
          '$urlBase/${tableData1.id}',
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => putTableWithNameAlreadyUsedExceptionResponse);

      final future = tablesService.putTable(tableData1);

      verify(
        () => connect.put(
          '$urlBase/${tableData1.id}',
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<TableNameAlreadyExistsException>()));
    });

    test('should throw DefaultException', () async {
      when(
        () => connect.put(
          '$urlBase/${tableData1.id}',
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      ).thenAnswer((_) async => putTableWithDefaultExceptionResponse);

      final future = tablesService.putTable(tableData1);

      verify(
        () => connect.put(
          '$urlBase/${tableData1.id}',
          tableData1.toJson(),
          decoder: any(named: 'decoder'),
        ),
      );

      expect(future, throwsA(isA<DefaultException>()));
    });
  });
}
