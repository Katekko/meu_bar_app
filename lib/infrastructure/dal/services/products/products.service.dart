import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/domain/core/exceptions/nonexistent.exception.dart';
import 'package:ekko/infrastructure/dal/services/data/error.response.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

import '../data/category.data.dart';
import 'dto/get_products.response.dart';
import 'dto/product.response.dart';

class ProductsService implements IProductsService {
  final IHttpConnect _connect;
  const ProductsService(IHttpConnect connect) : _connect = connect;

  final _prefix = 'products';

  @override
  Future<List<ProductData>> getProducts({
    String? filter,
    List<CategoryData>? categories,
  }) async {
    var url = filter != null ? '$_prefix?filter=$filter' : _prefix;

    // TODO: Testar se está criando a query de categorias corretamente
    if (categories != null) {
      url += 'categories=';
      for (var i = 0; i < categories.length; i++) {
        final item = categories[i];
        if (i == 0) {
          url += '${item.id}';
          break;
        }

        url += ',${item.id}';
      }
    }

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

  @override
  Future<void> createProduct(ProductData body) async {
    final response = await _connect.post(
      _prefix,
      body.toJson(),
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> updateProduct(ProductData body) async {
    final response = await _connect.put(
      _prefix,
      body.toJson(),
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> deleteProduct(ProductData body) async {
    final response = await _connect.delete(
      '$_prefix/${body.id}',
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<ProductData> getProductById(int id) async {
    final response = await _connect.get(
      '$_prefix/$id',
      decoder: ProductResponse.fromJson,
    );

    if (response.success) {
      return response.payload!.data!;
    } else {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        case ErrosConstants.nonexistent:
          throw NonexistentException(message: error.desc);
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }
}
