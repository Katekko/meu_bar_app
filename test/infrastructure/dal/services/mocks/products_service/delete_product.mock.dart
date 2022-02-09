import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';

const deleteProductWithSuccess = Response<ErrorResponse>(
  statusCode: 200,
  payload: ErrorResponse(success: true),
);

const deleteProductWithDefaultError = Response<ErrorResponse>(
  statusCode: 400,
  payload: ErrorResponse(
    success: false,
    errors: [ErrorData(id: -1, desc: 'Unknow error')],
  ),
);
