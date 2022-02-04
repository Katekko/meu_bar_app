import 'package:json_annotation/json_annotation.dart';

import 'category.data.dart';

part 'product.data.g.dart';

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
    this.urlImage,
  });

  factory ProductData.fromJson(json) => _$ProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}
