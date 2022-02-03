import 'package:json_annotation/json_annotation.dart';

import '../../data/error.data.dart';
import '../../data/product.data.dart';

part 'get_products.response.g.dart';

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
