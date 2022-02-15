import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../../domain/product/models/category.model.dart';

class CategoryItemListWidget extends ViewController<ICategoriesController> {
  final CategoryModel item;
  const CategoryItemListWidget(this.item);

  void editCategory(BuildContext context) {
    controller.editCategory(
      category: item,
      openScreen: (category) => Navigator.of(context).pushNamed(
        'categories/edit',
        arguments: {'category': category},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => editCategory(context),
      leading: item.icon != null
          ? Icon(IconData(item.icon!, fontFamily: 'MaterialIcons'))
          : null,
      title: Text(item.name),
    );
  }
}
