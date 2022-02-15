import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../widgets/categories/categories_list.widget.dart';

class CategoriesScreen extends ViewController<ICategoriesController> {
  void openCategoryScreen(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: CategoriesListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openCategoryScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
