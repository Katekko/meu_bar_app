import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';

import '../../../../../tables.mocks.dart';
import '../../tables_service_test.dart';

final getTablesWithSuccessResponse = Response(
  statusCode: 200,
  payload: GetTablesResponse(
    success: true,
    data: listTablesData,
    errors: null,
  ),
);
