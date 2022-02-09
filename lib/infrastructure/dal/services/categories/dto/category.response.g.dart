// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      success: json['success'] as bool,
      data: json['data'] == null ? null : CategoryData.fromJson(json['data']),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
