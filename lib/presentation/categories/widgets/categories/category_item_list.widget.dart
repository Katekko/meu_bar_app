import 'package:flutter/material.dart';

import '../../../../domain/product/models/category.model.dart';

class CategoryItemListWidget extends StatelessWidget {
  final CategoryModel item;
  const CategoryItemListWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
    );
  }
}
