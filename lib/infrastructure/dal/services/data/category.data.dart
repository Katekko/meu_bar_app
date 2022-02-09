import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.data.g.dart';

@JsonSerializable()
class CategoryData extends Equatable {
  final int id;
  final String name;
  const CategoryData({required this.id, required this.name});

  factory CategoryData.fromJson(json) => _$CategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);

  @override
  List<Object?> get props => [id, name];
}
