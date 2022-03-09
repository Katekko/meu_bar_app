import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/domain/table/models/category.mock.dart';
import 'package:ekko/infrastructure/dal/services/categories/dto/get_categories.response.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';

const getCategoriesWithSuccessResponse = Response(
  statusCode: 200,
  payload: GetCategoriesResponse(
    success: true,
    data: listCategoriesData,
    errors: null,
  ),
);

const getCategoriesWithUnknowErrorResponse = Response(
  statusCode: 400,
  payload: GetCategoriesResponse(
    success: true,
    data: null,
    errors: [ErrorData(id: ErrosConstants.unknow, desc: 'Unknow error')],
  ),
);
