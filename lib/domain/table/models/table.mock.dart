import 'package:ekko/domain/table/models/table.model.dart';
import 'package:ekko/infrastructure/dal/services/data/table.data.dart';

import 'product.mock.dart';

final tablesData1 = TableData(
  id: 1,
  name: 'Table 1',
  products: listProductsData,
);

final tablesData2 = TableData(
  id: 2,
  name: 'Table 2',
  products: listProductsData,
);

const tablesData3 = TableData(id: 3, name: 'Table 3', products: []);

final listTablesData = [tablesData1, tablesData2, tablesData3];

final tablesModel1 = TableModel(
  id: 1,
  name: 'Table 1',
  products: listProductsModel,
);

final tablesModel2 = TableModel(
  id: 2,
  name: 'Table 2',
  products: listProductsModel,
);

const tablesModel3 = TableModel(id: 3, name: 'Table 3', products: []);

final listTablesModel = [tablesModel1, tablesModel2, tablesModel3];
