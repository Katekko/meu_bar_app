import 'package:ekko/domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import 'package:ekko/presentation/products/widgets/products/products_list.widget.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../../shared/loading/loading.widget.dart';

class ProductsScreen extends ViewController<IProductsController> {
  void openProductScreen(BuildContext context) {
    controller.createProduct(
      openScreen: () => Navigator.of(context).pushNamed(Routes.createProduct),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(title: const Text('Produtos')),
        body: ProductsListWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openProductScreen(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
