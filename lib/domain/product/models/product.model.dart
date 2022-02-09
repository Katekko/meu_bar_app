import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final double price;
  final CategoryModel category;

  final String? urlImage;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.urlImage,
  });

  factory ProductModel.fromData(ProductData data) {
    return ProductModel(
      id: data.id,
      name: data.name,
      price: data.price,
      urlImage: data.urlImage,
      category: CategoryModel.fromData(data.category),
    );
  }

  ProductData toData() {
    return ProductData(
      id: id,
      name: name,
      price: price,
      category: category.toData(),
    );
  }

  @override
  List<Object?> get props => [id, name, price, category, urlImage];
}
