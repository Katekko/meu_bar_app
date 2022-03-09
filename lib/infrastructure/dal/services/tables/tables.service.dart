import '../../../../domain/core/abstractions/infrastructure/http_connect.interface.dart';
import '../../../../domain/core/abstractions/infrastructure/services/table_service.interface.dart';
import '../data/table.data.dart';
import 'dto/get_tables.response.dart';

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
