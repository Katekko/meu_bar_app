import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search.controller.dart';
import '../interfaces/searchable.interface.dart';

class SearchItemWidget<T extends ISearchable>
    extends GetView<SearchController<T>> {
  /// Titulo que irá aparecer no item buildado
  final String title;

  /// Descrição do item, clique e segure para aparecer
  final String? desc;

  // Icone para aparecer do lado do item
  final IconData? icon;

  // Item a ser adicionado
  final T item;

  const SearchItemWidget({
    required this.title,
    required this.item,
    this.icon,
    this.desc,
  });

  List<TextSpan> highlightOccurrences(
    String source,
    String query,
    BuildContext context,
  ) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    var lastMatchEnd = 0;

    final children = <TextSpan>[];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(
          TextSpan(text: source.substring(lastMatchEnd, match.start)),
        );
      }

      children.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      );

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(
          TextSpan(text: source.substring(match.end, source.length)),
        );
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var selected = false;
        if (controller.isMulti) {
          selected = controller.selectedItems.any((e) => e.guid == item.guid);
        } else {
          selected = controller.currentItem.value?.guid == item.guid;
        }

        return Material(
          borderRadius: BorderRadius.circular(100),
          color: selected ? Colors.white.withOpacity(.08) : Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            splashColor: Colors.white.withOpacity(.08),
            onTap: () {
              if (selected) {
                if (controller.isMulti) {
                  controller.removeMultiItem(item);
                }
              } else {
                if (controller.isMulti) {
                  controller.addMultiItem(item);
                } else {
                  controller.callBackSingleSelect(item);
                }
              }

              if (!controller.isMulti) Get.back();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(
                controller.isCategoriesMode ? 32 : 16,
                16,
                16,
                16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              constraints: const BoxConstraints(minHeight: 56),
              child: Row(
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        icon,
                        size: 24,
                        color: selected ? Colors.black87 : Colors.black45,
                      ),
                    ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: highlightOccurrences(
                          title,
                          controller.searchText.value,
                          context,
                        ),
                        style: Get.textTheme.bodyText1!.copyWith(
                          color: selected ? Colors.black87 : Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (controller.isMulti)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: _CheckboxWidget(isSelected: selected),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CheckboxWidget extends StatelessWidget {
  final bool isSelected;
  const _CheckboxWidget({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isSelected,
      child: Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: const Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
