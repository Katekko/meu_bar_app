import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_history.data.g.dart';

@JsonSerializable()
class TableHistoryData extends Equatable {
  final int id;
  final String description;

  const TableHistoryData({required this.id, required this.description});

  factory TableHistoryData.fromJson(json) => _$TableHistoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$TableHistoryDataToJson(this);

  @override
  List<Object?> get props => [id, description];
}
