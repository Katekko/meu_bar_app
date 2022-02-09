import 'package:json_annotation/json_annotation.dart';

import '../../data/error.data.dart';
import '../../data/product.data.dart';

part 'product.response.g.dart';

@JsonSerializable(createToJson: false)
class ProductResponse {
  final bool success;
  final ProductData? data;
  final List<ErrorData>? errors;

  const ProductResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory ProductResponse.fromJson(json) => _$ProductResponseFromJson(json);
}
