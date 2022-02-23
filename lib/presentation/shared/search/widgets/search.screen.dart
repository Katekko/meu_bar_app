import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../loading/loading.widget.dart';
import '../controllers/search.controller.dart';
import '../interfaces/searchable.interface.dart';

class SearchScreen<T extends ISearchable> extends GetView<SearchController<T>> {
  final Widget Function(T) buildDropdownItem;
  final Widget Function(T)? buildChipItem;

  const SearchScreen({
    required this.buildDropdownItem,
    this.buildChipItem,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.isMulti) {
      assert(
        buildChipItem != null,
        'Para multisearch é necessário implementar o buildChipItem',
      );
    }

    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: LoadingWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _TextFieldWidget<T>(),
                      if (controller.isMulti)
                        _ChipsWidget<T>(buildChipItem: buildChipItem!),
                      if (controller.isMulti && !controller.isCategoriesMode)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: _SelectAllButtonWidget<T>(),
                        )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _ListWidget(
                  buildDropdownItem: buildDropdownItem,
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: controller.isMulti,
                          child: _ConcluirButtonWidget<T>(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      _CloseButtonWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldWidget<T extends ISearchable>
    extends GetView<SearchController<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: TextFormField(
        onChanged: controller.setTextTextFormField,
        onFieldSubmitted: controller.searchText,
        textInputAction: TextInputAction.search,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.black45,
              fontWeight: FontWeight.w600,
            ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          hintText: 'Pesquise aqui',
          suffixIcon: const Icon(Icons.search, color: Colors.black45),
          filled: true,
          fillColor: Colors.black12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipsWidget<T extends ISearchable> extends GetView<SearchController<T>> {
  final Widget Function(T) buildChipItem;
  const _ChipsWidget({required this.buildChipItem});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Obx(
        () => Visibility(
          visible: controller.selectedItems.isNotEmpty,
          child: SizedBox(
            height: 40,
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.selectedItems.length,
                controller: controller.chipsScrollController,
                separatorBuilder: (_, __) => const SizedBox(width: 5),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final item = controller.selectedItems[index];
                  return buildChipItem(item);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListWidget<T extends ISearchable> extends GetView<SearchController<T>> {
  final Widget Function(T) buildDropdownItem;
  const _ListWidget({required this.buildDropdownItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 4),
      child: RawScrollbar(
        thumbColor: Colors.black87,
        radius: const Radius.circular(100),
        thickness: 3,
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: controller.isCategoriesMode
              ? _CategoriesListWidget(
                  buildDropdownItem: buildDropdownItem,
                )
              : _NormalListWidget(buildDropdownItem: buildDropdownItem),
        ),
      ),
    );
  }
}

class _SelectAllButtonWidget<T extends ISearchable>
    extends GetView<SearchController<T>> {
  final int? indexCategory;
  final String? keyCategory;
  const _SelectAllButtonWidget({this.indexCategory, this.keyCategory});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var color = Theme.of(context).primaryColor;
        var style = Theme.of(context).textTheme.headline5!;
        var text = 'Selecionar todos';

        if (controller.isCategoriesMode) {
          if (controller.allCategorySelected(
            index: indexCategory!,
            key: keyCategory!,
          )) {
            color = Colors.red.shade700;
            text = 'Desmarcar tudo';
          }
        } else {
          if (controller.allSelected) {
            color = Colors.red.shade700;
            text = 'Desmarcar tudo';
          }
        }

        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => controller.toogleSelectAll(
              index: indexCategory,
              key: keyCategory,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 1, 0, 1),
              child: Text(
                text,
                style: style.copyWith(color: color),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NormalListWidget<T extends ISearchable>
    extends GetView<SearchController<T>> {
  final Widget Function(T) buildDropdownItem;
  final Widget Function()? buildDropdownItemTodos;

  const _NormalListWidget({
    required this.buildDropdownItem,
    this.buildDropdownItemTodos,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: controller.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 4),
        itemBuilder: (_, index) {
          final item = controller.items[index];
          return buildDropdownItem(item);
        },
      ),
    );
  }
}

class _CategoriesListWidget<T extends ISearchable>
    extends GetView<SearchController<T>> {
  final Widget Function(T) buildDropdownItem;
  final Widget Function()? buildDropdownItemTodos;

  const _CategoriesListWidget({
    required this.buildDropdownItem,
    this.buildDropdownItemTodos,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.categoriesItems.length,
        itemBuilder: (_, indexCategory) {
          final map = controller.categoriesItems[indexCategory];
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: map.keys.map((key) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            key,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.black12,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        _SelectAllButtonWidget<T>(
                          indexCategory: indexCategory,
                          keyCategory: key,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: map[key]!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final item = map[key]![index];
                      return buildDropdownItem(item);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _ConcluirButtonWidget<T extends ISearchable>
    extends GetView<SearchController<T>> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextButton(
        onPressed: () {
          controller.enableButton ? controller.callBackMultiSelect() : null;
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          splashFactory:
              controller.enableButton ? null : NoSplash.splashFactory,
          backgroundColor: controller.enableButton
              ? Theme.of(context).primaryColor
              : Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: SizedBox(
          height: 40,
          child: Center(
            child: Text(
              'Concluir',
              style: TextStyle(
                color: controller.enableButton ? Colors.white : Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CloseButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Get.back,
      borderRadius: BorderRadius.circular(10000),
      child: Container(
        width: 40,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Center(
          child: Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
