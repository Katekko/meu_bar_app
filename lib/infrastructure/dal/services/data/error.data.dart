import 'package:json_annotation/json_annotation.dart';

part 'error.data.g.dart';

@JsonSerializable()
class ErrorData {
  final String id;
  final String desc;

  const ErrorData({required this.id, required this.desc});

  factory ErrorData.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDataToJson(this);
}
