import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/infrastructure/dal/services/categories/dto/get_categories.response.dart';

import '../../../../../products.mocks.dart';

const getCategoriesWithSuccessResponse = Response(
  statusCode: 200,
  payload: GetCategoriesResponse(
    success: true,
    data: listCategoriesData,
    errors: null,
  ),
);
