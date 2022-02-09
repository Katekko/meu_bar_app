import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';

const withSuccess = Response<ErrorResponse>(
  statusCode: 200,
  payload: ErrorResponse(success: true),
);

const unknowError = Response<ErrorResponse>(
  statusCode: 400,
  payload: ErrorResponse(
    success: false,
    errors: [ErrorData(id: ErrosConstants.unknow, desc: 'Unknow error')],
  ),
);
