import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/table/models/product.mock.dart';
import 'package:ekko/infrastructure/dal/services/products/dto/get_products.response.dart';

final getProductsWithSuccessResponse = Response(
  statusCode: 200,
  payload: GetProductsResponse(
    success: true,
    data: listProductsData,
    errors: null,
  ),
);
