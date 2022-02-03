import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';

import '../../products_service_test.dart';

const listCategories = [
  CategoryData(id: 1, name: 'Bebidas'),
  CategoryData(id: 2, name: 'Comidas'),
  CategoryData(id: 2, name: 'Outros'),
];

const getProductsWithSuccessResponse = Response(
  statusCode: 200,
  payload: GetProductsResponse(
    success: true,
    data: listCategories,
    errors: null,
  ),
);
