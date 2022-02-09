import 'package:json_annotation/json_annotation.dart';

import '../../data/category.data.dart';
import '../../data/error.data.dart';

part 'get_categories.response.g.dart';

@JsonSerializable(createToJson: false)
class GetCategoriesResponse {
  final bool success;
  final List<CategoryData>? data;
  final List<ErrorData>? errors;

  const GetCategoriesResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory GetCategoriesResponse.fromJson(json) =>
      _$GetCategoriesResponseFromJson(json);
}
