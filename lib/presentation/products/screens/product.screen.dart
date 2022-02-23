import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../shared/text_field.widget.dart';

class ProductScreen extends ViewController<IProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.isEdit ? 'Atualizando um Produto' : 'Criando um Produto',
        ),
      ),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
