import 'package:ekko/infrastructure/dal/services/data/product.data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_products.body.g.dart';

@JsonSerializable(createFactory: false)
class AddProductsBody {
  final List<ProductData> products;
  const AddProductsBody({required this.products});

  Map<String, dynamic> toJson() => _$AddProductsBodyToJson(this);
}
