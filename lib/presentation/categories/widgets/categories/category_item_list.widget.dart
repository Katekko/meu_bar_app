import 'package:flutter/material.dart';

import '../../../../domain/product/models/category.model.dart';

class CategoryItemListWidget extends StatelessWidget {
  final CategoryModel item;
  const CategoryItemListWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: item.icon != null
          ? Icon(IconData(item.icon!, fontFamily: 'MaterialIcons'))
          : null,
      title: Text(item.name),
    );
  }
}
