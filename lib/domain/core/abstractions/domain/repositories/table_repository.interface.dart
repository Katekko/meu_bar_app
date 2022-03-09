import 'package:ekko/domain/table/models/table.model.dart';

abstract class ITableRepository {
  Future<List<TableModel>> getTables();
}
