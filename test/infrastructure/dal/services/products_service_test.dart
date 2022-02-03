import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import 'mocks/products_service/get_products.mock.dart';

part 'products_service_test.g.dart';

@JsonSerializable()
class CategoryData {
  final int id;
  final String name;
  const CategoryData({required this.id, required this.name});

  factory CategoryData.fromJson(json) => _$CategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}

@JsonSerializable()
class ProductData {
  final int id;
  final String name;
  final double value;
  final CategoryData category;

  final String? urlImage;

  const ProductData({
    required this.id,
    required this.name,
    required this.value,
    required this.category,
    required this.urlImage,
  });

  factory ProductData.fromJson(json) => _$ProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}

@JsonSerializable(createToJson: false)
class GetProductsResponse {
  final bool success;
  final List<ProductData>? data;
  final List<ErrorData>? errors;

  const GetProductsResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory GetProductsResponse.fromJson(json) =>
      _$GetProductsResponseFromJson(json);
}

abstract class IProductsService {
  Future<List<ProductData>> getProducts({String? filter});
}

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

void main() {
  late IProductsService productsService;
  late IHttpConnect connect;

  setUpAll(() {
    connect = ConnectMock();
    productsService = ProductsService(connect);
  });

  group('Get products', () {
    test(
      'Should get all products with success',
      () async {
        when(
          () => connect.get('products', decoder: any(named: 'decoder')),
        ).thenAnswer((_) async => getProductsWithSuccessResponse);

        final response = await productsService.getProducts();

        expect(response, listProducts);
      },
    );

    test(
      'Should get products passing filter with success',
      () async {
        when(
          () => connect.get(
            'products?filter=cer',
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => getProductsWithSuccessResponse);

        final response = await productsService.getProducts(filter: 'cer');

        expect(response, listProducts);
      },
    );
  });
}
