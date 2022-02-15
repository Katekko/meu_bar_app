import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/presentation/shared/loading/loading.widget.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/navigation/routes.dart';
import '../widgets/categories/categories_list.widget.dart';

class CategoriesScreen extends ViewController<ICategoriesController> {
  void openCategoryScreen(BuildContext context) {
    controller.createCategory(
      openScreen: () => Navigator.of(context).pushNamed(Routes.createCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(title: const Text('Categorias')),
        body: CategoriesListWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openCategoryScreen(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
