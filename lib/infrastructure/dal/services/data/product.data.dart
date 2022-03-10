import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category.data.dart';

part 'product.data.g.dart';

@JsonSerializable()
class ProductData extends Equatable {
  final int id;
  final String name;
  final double price;
  final CategoryData category;

  final String? urlImage;
  final String? base64Image;

  final int amount;

  const ProductData({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.amount = 0,
    this.urlImage,
    this.base64Image,
  });

  factory ProductData.fromJson(json) => _$ProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataToJson(this);

  @override
  List<Object?> get props => [id, name, price, category, urlImage];
}
