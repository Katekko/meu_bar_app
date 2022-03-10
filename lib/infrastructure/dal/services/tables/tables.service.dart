import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/domain/core/exceptions/table_name_already_exists.exception.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';

import '../../../../domain/core/abstractions/infrastructure/http_connect.interface.dart';
import '../../../../domain/core/abstractions/infrastructure/services/table_service.interface.dart';
import '../../../../domain/core/exceptions/default.exception.dart';
import '../data/table.data.dart';
import 'dto/get_tables.response.dart';

class TablesService implements ITablesService {
  final IHttpConnect _connect;
  const TablesService(IHttpConnect connect) : _connect = connect;

  final urlBase = 'tables';

  @override
  Future<List<TableData>> getTables() async {
    final response = await _connect.get(
      urlBase,
      decoder: GetTablesResponse.fromJson,
    );

    if (response.success) {
      return response.payload!.data!;
    } else {
      throw DefaultException(message: response.payload!.errors!.first.desc);
    }
  }

  @override
  Future<void> postTable(TableData body) async {
    final response = await _connect.post(
      urlBase,
      body.toJson(),
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      switch (response.payload!.errors!.first.id) {
        case ErrorsConstants.tableNameAlreadyExists:
          throw TableNameAlreadyExistsException();
        default:
          throw DefaultException(message: response.payload!.errors!.first.desc);
      }
    }
  }
}
