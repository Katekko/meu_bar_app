import 'package:ekko/domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../shared/search/functions/search.functions.dart';
import '../../../shared/search/widgets/search_item.widget.dart';

class CategoryWidget extends ViewController<IProductController> {
  void openCategoriesSearch(BuildContext context) {
    FocusScope.of(context).unfocus();
    SearchFunctions.openSingleSearchDialog<CategoryModel>(
      callbackItems: controller.loadCategories,
      onSingleSelected: (category) => controller.categoryField.value = category,
      currentItem: controller.categoryField.value,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Escolha a categoria do produto:',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 5),
        StreamBuilder<CategoryModel?>(
          stream: controller.categoryField.stream,
          builder: (_, snap) {
            return InkWell(
              onTap: () => openCategoriesSearch(context),
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Ink(
                          child: snap.hasData
                              ? Icon(
                                  IconData(
                                    snap.data!.icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Ink(
                          child: snap.hasData
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      snap.data!.name,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
