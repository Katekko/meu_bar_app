import 'package:json_annotation/json_annotation.dart';

import 'error.data.dart';

part 'error.response.g.dart';

@JsonSerializable()
class ErrorResponse {
  final bool success;
  final List<ErrorData>? errors;

  const ErrorResponse({required this.success, this.errors});

  factory ErrorResponse.fromJson(json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
