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
}
