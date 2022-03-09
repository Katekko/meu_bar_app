import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/table_service.interface.dart';
import 'package:ekko/infrastructure/dal/services/tables/tables.service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import 'mocks/tables_service/get_tables.mock.dart';

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
        // arrange
        when(() => connect.get(urlBase, decoder: any(named: 'decoder')))
            .thenAnswer(
          (_) async => getTablesWithSuccessResponse,
        );

        // action
        final response = await tablesService.getTables();

        // assert
        expect(response, getTablesWithSuccessResponse.payload!.data);
      },
    );
  });
}
