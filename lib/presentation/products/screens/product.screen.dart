import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/presentation/shared/loading/loading.widget.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../shared/text_field.widget.dart';
import '../widgets/product/category.widget.dart';

class ProductScreen extends ViewController<IProductController> {
  void createProduct(BuildContext context) {
    controller.saveProduct(
      backScreen: Navigator.of(context).pop,
      onError: (err) => SnackbarUtil.showError(err.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            controller.isEdit ? 'Atualizando um Produto' : 'Criando um Produto',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFieldWidget(
                  label: 'Nome do Produto',
                  field: controller.nameField,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  label: 'Descrição',
                  field: controller.descriptionField,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  label: 'Quanto custa?',
                  field: controller.priceField,
                  isCurrency: true,
                ),
                const SizedBox(height: 20),
                CategoryWidget(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => createProduct(context),
          label: Text(
            controller.isEdit ? 'EDITAR PRODUTO' : 'CRIAR PRODUTO',
          ),
          icon: const Icon(Icons.save),
        ),
      ),
    );
  }
}
