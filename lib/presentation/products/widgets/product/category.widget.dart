import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../shared/search/functions/search.functions.dart';
import '../../../shared/search/widgets/search_item.widget.dart';

class CategoryWidget extends ViewController<IProductController> {
  bool filterCategories(CategoryModel item, String searchText) {
    return item.desc.toLowerCase().contains(searchText.toLowerCase());
  }

  void openCategoriesSearch({required List<CategoryModel> items}) {
    SearchFunctions.openSingleSearchDialog<CategoryModel>(
      items: items,
      onSingleSelected: (category) => controller.categoryField.value = category,
      currentItem: controller.categoryField.value,
      onFilter: filterCategories,
      buildDropdownItem: (item) {
        return SearchItemWidget<CategoryModel>(
          item: item,
          title: item.desc,
          icon: IconData(item.icon, fontFamily: 'MaterialIcons'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CategoryModel?>(
      stream: controller.categoryField.stream,
      builder: (_, snap) {
        return InkWell(
          onTap: () {},
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Ink(
                    height: 50,
                    child: snap.hasData
                        ? Icon(IconData(snap.data!.icon))
                        : const SizedBox(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Ink(
                    height: 50,
                    child:
                        snap.hasData ? Text(snap.data!.name) : const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
