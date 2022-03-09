import 'package:ekko/domain/core/abstractions/domain/repositories/table_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/table_service.interface.dart';

import 'models/table.model.dart';

class TableRepository implements ITableRepository {
  final ITablesService tablesService;
  const TableRepository({required this.tablesService});

  @override
  Future<List<TableModel>> getTables() async {
    try {
      final response = await tablesService.getTables();
      final models = response.map((e) => TableModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }
}
