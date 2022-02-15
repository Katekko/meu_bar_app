import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/categories/widgets/categories/category_item_list.widget.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

class CategoriesListWidget extends ViewController<ICategoriesController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: controller.categories,
      builder: (_, listSnap) {
        if (listSnap.hasData) {
          final list = listSnap.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              final item = list[index];
              return CategoryItemListWidget(item);
            },
          );
        }

        if (listSnap.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Erro ao carregar categorias, tente novamente'),
                IconButton(
                  onPressed: controller.loadCategories,
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
