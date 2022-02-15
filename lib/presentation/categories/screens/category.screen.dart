import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../shared/text_field.widget.dart';
import '../widgets/category/icon_picker.widget.dart';

class CategoryScreen extends ViewController<ICategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.isEdit ? 'Edite sua categoria' : 'Cria uma categoria',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFieldWidget(
              label: 'Nome da Categoria',
              field: controller.nameField,
            ),
            const SizedBox(height: 20),
            IconPickerWidget(),
          ],
        ),
      ),
    );
  }
}
