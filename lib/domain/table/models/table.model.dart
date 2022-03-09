import 'package:ekko/domain/table/models/product.model.dart';
import 'package:ekko/infrastructure/dal/services/data/table.data.dart';
import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  final int id;
  final String name;
  final List<ProductModel> products;

  const TableModel({
    required this.id,
    required this.name,
    required this.products,
  });

  factory TableModel.fromData(TableData data) {
    return TableModel(
      id: data.id,
      name: data.name,
      products: data.products.map((e) => ProductModel.fromData(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, products];
}
