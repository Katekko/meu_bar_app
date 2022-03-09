import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:equatable/equatable.dart';

class TableData extends Equatable {
  final int id;
  final String name;
  final List<ProductData> products;

  const TableData({
    required this.id,
    required this.name,
    required this.products,
  });

  @override
  List<Object?> get props => [id, name, products];
}
