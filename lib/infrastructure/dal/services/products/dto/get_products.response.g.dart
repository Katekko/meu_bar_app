// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductsResponse _$GetProductsResponseFromJson(Map<String, dynamic> json) =>
    GetProductsResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductData.fromJson(e))
          .toList(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
