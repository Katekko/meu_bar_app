import 'dart:convert';
import 'dart:typed_data';

import 'package:ekko/domain/table/models/category.model.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String? description;
  final double price;
  final CategoryModel category;

  /// Utilizado para receber a imagem do backend
  final String? urlImage;

  /// Utilizado para enviar a imagem para o backend
  final Uint8List? imageBytes;

  final int amount;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.amount = 0,
    this.imageBytes,
    this.urlImage,
    this.description,
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
    String? base64Image;
    if (imageBytes != null) base64Image = base64Encode(imageBytes!);

    return ProductData(
      id: id,
      name: name,
      price: price,
      category: category.toData(),
      base64Image: base64Image,
    );
  }

  @override
  List<Object?> get props => [id, name, price, category, urlImage, description];
}
