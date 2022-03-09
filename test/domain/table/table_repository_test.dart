import 'package:ekko/domain/core/abstractions/infrastructure/services/table_service.interface.dart';
import 'package:ekko/domain/table/models/product.mock.dart';
import 'package:ekko/domain/table/models/product.model.dart';
import 'package:ekko/domain/table/models/table.mock.dart';
import 'package:ekko/infrastructure/dal/services/data/table.data.dart';
import 'package:equatable/equatable.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

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

class TableModel extends Equatable {
  final int id;
  final String name;
  final List<ProductModel> products;

  const TableModel({
    required this.id,
    required this.name,
    required this.products,
  });

  factory TableModel.fromData(TableData data) {
    return TableModel(
      id: data.id,
      name: data.name,
      products: data.products.map((e) => ProductModel.fromData(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, products];
}

abstract class ITableRepository {
  Future<List<TableModel>> getTables();
}

void main() {
  late final ITableRepository tableRepository;
  late final ITablesService tablesService;

  setUpAll(() {
    tablesService = TablesServiceMock();
    tableRepository = TableRepository(tablesService: tablesService);
  });

  group('Get tables', () {
    test('should get with success', () async {
      when(tablesService.getTables).thenAnswer((_) async => listTablesData);

      final response = await tableRepository.getTables();

      expect(response, listTablesModel);
    });
  });
}
