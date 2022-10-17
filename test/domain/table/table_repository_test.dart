import 'package:ekko/domain/core/abstractions/domain/repositories/table_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/table_service.interface.dart';
import 'package:ekko/domain/table/models/table.mock.dart';
import 'package:ekko/domain/table/table.repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

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
