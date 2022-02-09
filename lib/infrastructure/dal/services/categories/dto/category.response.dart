import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/error.data.dart';

part 'category.response.g.dart';

@JsonSerializable(createToJson: false)
class CategoryResponse {
  final bool success;
  final CategoryData? data;
  final List<ErrorData>? errors;

  const CategoryResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory CategoryResponse.fromJson(json) => _$CategoryResponseFromJson(json);
}
