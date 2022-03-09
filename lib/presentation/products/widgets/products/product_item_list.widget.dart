import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import '../../../../domain/core/utils/money.util.dart';
import '../../../../domain/table/models/product.model.dart';
import '../../../../infrastructure/navigation/routes.dart';

class ProductItemListWidget extends ViewController<IProductsController> {
  final ProductModel item;
  const ProductItemListWidget(this.item);

  void editCategory(BuildContext context) {
    controller.editProduct(
      product: item,
      openScreen: (product) => Navigator.of(context).pushNamed(
        Routes.editProduct,
        arguments: {'product': product},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => editCategory(context),
      child: Ink(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.urlImage != null)
                Hero(
                  tag: item.urlImage!,
                  child: Image.network(item.urlImage!, width: 50),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    item.description != null
                        ? Text(
                            item.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              Text(
                MoneyUtil.formatBRL(item.price),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
