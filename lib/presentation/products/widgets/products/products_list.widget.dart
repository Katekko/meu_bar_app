import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import 'product_item_list.widget.dart';

class ProductsListWidget extends ViewController<IProductsController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: controller.productsStream,
      builder: (_, listSnap) {
        if (listSnap.hasData) {
          final list = listSnap.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              final item = list[index];
              return ProductItemListWidget(item);
            },
          );
        }

        if (listSnap.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Erro ao carregar produtos, tente novamente'),
                IconButton(
                  onPressed: controller.loadProducts,
                  icon: const Icon(Icons.refresh),
                )
              ],
            ),
          );
        }

        //TODO: Adicionar shimmer
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
