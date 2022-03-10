import 'package:ekko/infrastructure/dal/services/data/table.data.dart';

abstract class ITablesService {
  Future<List<TableData>> getTables();

  Future<void> postTable(TableData body);

  Future<void> putTable(TableData body);
}
