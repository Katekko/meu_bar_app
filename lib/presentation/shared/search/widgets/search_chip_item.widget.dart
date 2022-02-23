import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search.controller.dart';
import '../search.dart';

class SearchChipItemWidget<T extends ISearchable>
    extends GetView<SearchController<T>> {
  final T item;
  final String desc;
  const SearchChipItemWidget({required this.item, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            desc,
            style: Get.textTheme.caption!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => controller.removeMultiItem(item),
            child: Icon(
              Icons.close,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
