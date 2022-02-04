import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';

const createProductWithSuccess = Response<ErrorResponse>(
  statusCode: 200,
  payload: ErrorResponse(success: true),
);
