import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
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

const getTablesWithDefaultExceptionResponse = Response(
  statusCode: 500,
  payload: GetTablesResponse(
    success: false,
    data: null,
    errors: [ErrorData(id: -1, desc: 'Unknow Error')],
  ),
);
