import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:ekko/infrastructure/dal/services/products/dto/product.response.dart';

const product = ProductData(
  id: 1,
  name: 'Amstel 600',
  category: CategoryData(id: 1, name: 'Bebidas'),
  urlImage: null,
  price: 10,
);

const getProductByIdWithSuccessResponse = Response(
  statusCode: 200,
  payload: ProductResponse(success: true, data: product, errors: null),
);

const getProductByIdWithNonexistentError = Response<ProductResponse>(
  statusCode: 400,
  payload: ProductResponse(
    success: false,
    data: null,
    errors: [
      ErrorData(id: ErrosConstants.nonexistent, desc: 'Nonexistent product')
    ],
  ),
);

const getProductByIdWithUnknowError = Response<ProductResponse>(
  statusCode: 400,
  payload: ProductResponse(
    success: false,
    data: null,
    errors: [ErrorData(id: ErrosConstants.unknow, desc: 'Unknow error')],
  ),
);
