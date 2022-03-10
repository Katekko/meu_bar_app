// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tables.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTablesResponse _$GetTablesResponseFromJson(Map<String, dynamic> json) =>
    GetTablesResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TableData.fromJson(e))
          .toList(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTablesResponseToJson(GetTablesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'errors': instance.errors,
    };
