import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:ekko/infrastructure/dal/services/data/table.data.dart';
import 'package:ekko/infrastructure/dal/services/data/table_history.data.dart';
import 'package:ekko/infrastructure/dal/services/tables/dto/add_products.body.dart';
import 'package:ekko/infrastructure/dal/services/tables/dto/edit_product_amount.body.dart';

abstract class ITablesService {
  Future<List<TableData>> getTables();

  Future<void> postTable(TableData body);

  Future<void> putTable(TableData body);

  Future<void> closeTable(TableData body);

  Future<void> addProducts({
    required int tableId,
    required AddProductsBody body,
  });

  Future<void> editProductAmount({
    required int tableId,
    required EditProductAmountBody body,
  });

  Future<void> removeProduct({required int tableId, required ProductData body});

  Future<List<TableHistoryData>> getTableHistory(int tableId);
}
