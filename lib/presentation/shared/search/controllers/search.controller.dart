import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../interfaces/searchable.interface.dart';

class SearchController<T extends ISearchable> extends GetxController {
  var itemsBackup = <T>[];
  final items = <T>[].obs;
  final Future<List<T>> Function(String)? callbackItems;
  final bool Function(T, String)? onFilter;

  final categoriesItems = <Map<String, List<T>>>[].obs;
  final Future<List<Map<String, List<T>>>> Function(String)?
      callbackCategoriesItems;

  final Function(T)? onSingleSelected;
  final Function(List<T>)? onMultiSelected;

  final textTextFormField = ''.obs;
  final searchText = ''.obs;

  final selectedItems = <T>[].obs;
  final currentItem = Rxn<T>();

  final chipsScrollController = ScrollController();

  late bool isMulti;

  final isLoading = false.obs;

  bool get allSelected {
    return selectedItems.length == items.length;
  }

  bool allCategorySelected({required int index, required String key}) {
    final itemsByCategory = categoriesItems[index][key]!;
    final allItems = itemsByCategory.where(
      (e) => selectedItems.any((s) => e.guid == s.guid),
    );

    return itemsByCategory.isEmpty
        ? false
        : itemsByCategory.length == allItems.length;
  }

  bool get enableButton => selectedItems.isNotEmpty;

  bool get isCategoriesMode => callbackCategoriesItems != null;

  SearchController({
    T? currentItem,
    List<T>? items,
    List<Map<String, List<T>>>? categoriesItems,
    this.callbackItems,
    this.callbackCategoriesItems,
    this.onSingleSelected,
    this.onMultiSelected,
    this.isMulti = false,
    this.onFilter,
  }) {
    if (items != null && items.isNotEmpty) {
      itemsBackup = items;
      this.items.addAll(items);
      selectedItems.assignAll(items);
    } else if (categoriesItems != null && categoriesItems.isNotEmpty) {
      this.categoriesItems.addAll(categoriesItems);
    }

    this.currentItem.value = currentItem;
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) async => searchItems(''),
    );
    debounce<String>(
      textTextFormField,
      searchItems,
      time: const Duration(milliseconds: 300),
    );
  }

  List<T> _filterItems(String text) {
    return itemsBackup.where((item) => onFilter!.call(item, text)).toList();
  }

  Future<void> searchItems(String text) async {
    try {
      isLoading.value = true;
      searchText.value = text;
      if (onFilter != null) {
        final items = _filterItems.call(text);
        this.items.assignAll(items);
      } else if (callbackItems != null) {
        final items = await callbackItems!.call(text);
        this.items.assignAll(items);
      } else {
        final categoriesItems = await callbackCategoriesItems!.call(text);
        this.categoriesItems.assignAll(categoriesItems);
      }
    } catch (err) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void backScreen() {
    Get.back();
  }

  void setTextTextFormField(String texto) {
    textTextFormField.value = texto;
  }

  void callBackMultiSelect() {
    onMultiSelected?.call(selectedItems);
    Get.back();
  }

  void callBackSingleSelect(T item) {
    onSingleSelected?.call(item);
  }

  void addMultiItem(T item) {
    selectedItems.add(item);
    animateToEndChips();
  }

  void removeMultiItem(T item) {
    selectedItems.removeWhere((i) => i.guid == item.guid);
  }

  void animateToEndChips() async {
    if (chipsScrollController.hasClients) {
      await Future.delayed(const Duration(milliseconds: 800));
      chipsScrollController.animateTo(
        chipsScrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  void toogleSelectAll({int? index, String? key}) {
    if (isCategoriesMode) {
      assert(index != null && key != null, 'Index e Key são obrigatórios');
      final itemsByCategory = categoriesItems[index!][key!]!;
      if (allCategorySelected(key: key, index: index)) {
        selectedItems.removeWhere(
          (e) => itemsByCategory.any((i) => i.guid == e.guid),
        );
      } else {
        selectedItems.addAll(itemsByCategory);
      }
    } else {
      if (allSelected) {
        selectedItems.clear();
      } else {
        selectedItems.assignAll(items);
      }
    }
    animateToEndChips();
  }
}
