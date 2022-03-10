// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableData _$TableDataFromJson(Map<String, dynamic> json) => TableData(
      id: json['id'] as int,
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductData.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$TableDataToJson(TableData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'products': instance.products,
    };
