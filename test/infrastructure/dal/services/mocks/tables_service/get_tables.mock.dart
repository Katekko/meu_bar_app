import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/infrastructure/dal/services/tables/dto/get_tables.response.dart';

import '../../../../../tables.mocks.dart';

final getTablesWithSuccessResponse = Response(
  statusCode: 200,
  payload: GetTablesResponse(
    success: true,
    data: listTablesData,
    errors: null,
  ),
);
