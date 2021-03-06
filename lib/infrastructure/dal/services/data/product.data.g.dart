// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      category: CategoryData.fromJson(json['category']),
      amount: json['amount'] as int? ?? 0,
      urlImage: json['urlImage'] as String?,
      base64Image: json['base64Image'] as String?,
    );

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'category': instance.category,
      'urlImage': instance.urlImage,
      'base64Image': instance.base64Image,
      'amount': instance.amount,
    };
