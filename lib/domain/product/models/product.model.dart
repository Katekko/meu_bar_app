import 'package:ekko/domain/product/models/category.model.dart';

class ProductModel {
  final int id;
  final String name;
  final double value;
  final CategoryModel category;

  final String urlImage;

  const ProductModel({
    required this.id,
    required this.name,
    required this.value,
    required this.category,
    required this.urlImage,
  });
}
