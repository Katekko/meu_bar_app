import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:equatable/equatable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import 'mocks/tables_service/get_tables.mock.dart';

class GetTablesResponse {
  final bool success;
  final List<TableData>? data;
  final List<ErrorData>? errors;

  const GetTablesResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory GetTablesResponse.fromJson(json) => const GetTablesResponse(
        data: [],
        errors: null,
        success: true,
      );
}

class TablesService implements ITablesService {
  final IHttpConnect _connect;
  const TablesService(IHttpConnect connect) : _connect = connect;

  final urlBase = 'tables';

  @override
  Future<List<TableData>> getTables() async {
    try {
      final response = await _connect.get(
        urlBase,
        decoder: GetTablesResponse.fromJson,
      );

      return response.payload!.data!;
    } catch (err) {
      rethrow;
    }
  }
}

class TableData extends Equatable {
  final int id;
  final String name;
  final List<ProductData> products;

  const TableData({
    required this.id,
    required this.name,
    required this.products,
  });

  @override
  List<Object?> get props => [id, name, products];
}

abstract class ITablesService {
  Future<List<TableData>> getTables();
}

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
