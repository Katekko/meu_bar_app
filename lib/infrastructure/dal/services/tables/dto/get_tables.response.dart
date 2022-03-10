import '../../data/error.data.dart';
import '../../data/table.data.dart';

import 'package:json_annotation/json_annotation.dart';

part 'get_tables.response.g.dart';

@JsonSerializable()
class GetTablesResponse {
  final bool success;
  final List<TableData>? data;
  final List<ErrorData>? errors;

  const GetTablesResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory GetTablesResponse.fromJson(json) => _$GetTablesResponseFromJson(json);
}
