import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table.data.g.dart';

@JsonSerializable()
class TableData extends Equatable {
  final int id;
  final String name;
  final List<ProductData> products;

  const TableData({
    required this.id,
    required this.name,
    required this.products,
  });

  factory TableData.fromJson(json) => _$TableDataFromJson(json);
  Map<String, dynamic> toJson() => _$TableDataToJson(this);

  @override
  List<Object?> get props => [id, name, products];
}
