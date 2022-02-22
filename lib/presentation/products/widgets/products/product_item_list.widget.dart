import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import '../../../../domain/product/models/product.model.dart';

class ProductItemListWidget extends ViewController<IProductsController> {
  final ProductModel item;
  const ProductItemListWidget(this.item);

  void editCategory(BuildContext context) {
    controller.editProduct(
      product: item,
      openScreen: (product) => Navigator.of(context).pushNamed(
        '',
        arguments: {'product': product},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => editCategory(context),
      title: Text(item.name),
    );
  }
}
