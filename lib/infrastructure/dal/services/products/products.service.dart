import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

import 'dto/get_products.response.dart';

class ProductsService implements IProductsService {
  final IHttpConnect _connect;
  const ProductsService(IHttpConnect connect) : _connect = connect;

  final _prefix = 'products';

  @override
  Future<List<ProductData>> getProducts({String? filter}) async {
    final url = filter != null ? '$_prefix?filter=$filter' : _prefix;

    final response = await _connect.get(
      url,
      decoder: GetProductsResponse.fromJson,
    );

    if (response.success) {
      return response.payload!.data!;
    } else {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }
}
