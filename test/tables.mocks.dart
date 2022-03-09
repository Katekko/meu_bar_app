import 'infrastructure/dal/services/tables_service_test.dart';
import 'products.mocks.dart';

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

final tablesData3 = TableData(id: 3, name: 'Table 3', products: []);

final listTablesData = [tablesData1, tablesData2, tablesData3];
