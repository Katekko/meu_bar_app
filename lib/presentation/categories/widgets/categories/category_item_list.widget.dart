import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../../domain/product/models/category.model.dart';
import '../../../../infrastructure/navigation/routes.dart';

class CategoryItemListWidget extends ViewController<ICategoriesController> {
  final CategoryModel item;
  const CategoryItemListWidget(this.item);

  void editCategory(BuildContext context) {
    controller.editCategory(
      category: item,
      openScreen: (category) => Navigator.of(context).pushNamed(
        Routes.editCategory,
        arguments: {'category': category},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => editCategory(context),
      leading: Icon(IconData(item.icon, fontFamily: 'MaterialIcons')),
      title: Text(item.name),
    );
  }
}
