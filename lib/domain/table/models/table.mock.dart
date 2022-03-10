import 'package:ekko/domain/table/models/table.model.dart';
import 'package:ekko/infrastructure/dal/services/data/table.data.dart';

import 'product.mock.dart';

final tableData1 = TableData(
  id: 1,
  name: 'Table 1',
  products: listProductsData,
);

final tableData2 = TableData(
  id: 2,
  name: 'Table 2',
  products: listProductsData,
);

const tableData3 = TableData(id: 3, name: 'Table 3', products: []);

final listTablesData = [tableData1, tableData2, tableData3];

final tableModel1 = TableModel(
  id: 1,
  name: 'Table 1',
  products: listProductsModel,
);

final tableModel2 = TableModel(
  id: 2,
  name: 'Table 2',
  products: listProductsModel,
);

const tableModel3 = TableModel(id: 3, name: 'Table 3', products: []);

final listTablesModel = [tableModel1, tableModel2, tableModel3];
