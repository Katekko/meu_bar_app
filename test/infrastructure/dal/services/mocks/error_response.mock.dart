import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';

const responseWithSuccess = Response<ErrorResponse>(
  statusCode: 200,
  payload: ErrorResponse(success: true),
);

const responseWithUnknowError = Response<ErrorResponse>(
  statusCode: 400,
  payload: ErrorResponse(
    success: false,
    errors: [ErrorData(id: ErrorsConstants.unknow, desc: 'Unknow error')],
  ),
);
