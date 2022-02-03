// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      success: json['success'] as bool,
      error: json['error'] == null
          ? null
          : ErrorData.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
    };
