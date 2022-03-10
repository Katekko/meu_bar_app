import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';

const addProductsTableWithSuccessResponse = Response(
  statusCode: 200,
  payload: ErrorResponse(success: true, errors: null),
);

const addProductsTableWithDefaultExceptionResponse = Response(
  statusCode: 500,
  payload: ErrorResponse(
    success: false,
    errors: [ErrorData(id: ErrorsConstants.unknow, desc: 'Unknow Error')],
  ),
);
