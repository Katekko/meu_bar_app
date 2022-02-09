// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoriesResponse _$GetCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetCategoriesResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e))
          .toList(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
