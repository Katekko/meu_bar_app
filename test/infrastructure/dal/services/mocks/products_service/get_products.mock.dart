import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:ekko/infrastructure/dal/services/products/dto/get_products.response.dart';

const listCategories = [
  CategoryData(id: 1, name: 'Bebidas'),
  CategoryData(id: 2, name: 'Comidas'),
  CategoryData(id: 2, name: 'Outros'),
];

final listProducts = [
  ProductData(
    id: 1,
    name: 'Amstel 600',
    category: listCategories.first,
    urlImage: null,
    value: 10,
  ),
  ProductData(
    id: 2,
    name: 'Petra 600',
    category: listCategories.first,
    urlImage: null,
    value: 12,
  ),
];

final getProductsWithSuccessResponse = Response(
  statusCode: 200,
  payload: GetProductsResponse(success: true, data: listProducts, errors: null),
);
