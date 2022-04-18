import 'package:json_annotation/json_annotation.dart';

part 'edit_product_amount.body.g.dart';

@JsonSerializable(createFactory: false)
class EditProductAmountBody {
  final int productId;
  final int amount;
  const EditProductAmountBody({required this.productId, required this.amount});

  Map<String, dynamic> toJson() => _$EditProductAmountBodyToJson(this);
}
