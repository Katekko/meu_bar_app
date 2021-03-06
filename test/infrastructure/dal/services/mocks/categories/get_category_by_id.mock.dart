import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/domain/table/models/category.mock.dart';
import 'package:ekko/infrastructure/dal/services/categories/dto/category.response.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';

const getCategoryByIdWithSuccessResponse = Response(
  statusCode: 200,
  payload: CategoryResponse(success: true, data: categoryData1, errors: null),
);

const getCategoryByIdWithNonexistentError = Response<CategoryResponse>(
  statusCode: 400,
  payload: CategoryResponse(
    success: false,
    data: null,
    errors: [
      ErrorData(id: ErrorsConstants.nonexistent, desc: 'Nonexistent product')
    ],
  ),
);

const getCategoryByIdUnknowError = Response<CategoryResponse>(
  statusCode: 400,
  payload: CategoryResponse(
    success: false,
    data: null,
    errors: [
      ErrorData(id: ErrorsConstants.unknow, desc: 'Nonexistent product')
    ],
  ),
);
