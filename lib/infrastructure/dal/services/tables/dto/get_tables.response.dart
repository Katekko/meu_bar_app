import '../../data/error.data.dart';
import '../../data/table.data.dart';

class GetTablesResponse {
  final bool success;
  final List<TableData>? data;
  final List<ErrorData>? errors;

  const GetTablesResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory GetTablesResponse.fromJson(json) => const GetTablesResponse(
        data: [],
        errors: null,
        success: true,
      );
}
