import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search.controller.dart';
import '../interfaces/searchable.interface.dart';
import '../widgets/search.screen.dart';

class SearchFunctions {
  static void openSingleSearchDialog<T extends ISearchable>({
    Function(T)? onSingleSelected,
    required Widget Function(T) buildDropdownItem,
    required T? currentItem,
    required bool Function(T, String) onFilter,
    required List<T> items,
  }) {
    _openSearchDialog(
      onSingleSelected: onSingleSelected,
      buildDropdownItem: buildDropdownItem,
      currentItem: currentItem,
      items: items,
      onFilter: onFilter,
    );
  }

  static void openMultiSearchDialog<T extends ISearchable>({
    required Widget Function(T) buildDropdownItem,
    required Future<List<T>> Function(String)? callbackItems,
    Function(List<T>)? onMultiSelected,
    required List<T>? currentItems,
    required Widget Function(T)? buildChipItem,
  }) {
    _openSearchDialog(
      callbackItems: callbackItems,
      onMultiSelected: onMultiSelected,
      buildDropdownItem: buildDropdownItem,
      items: currentItems,
      isMulti: true,
      buildChipItem: buildChipItem,
    );
  }

  static void openSingleSearchCategoriesDialog<T extends ISearchable>({
    Function(T)? onSingleSelected,
    required Widget Function(T) buildDropdownItem,
    required T? currentItem,
    required Future<List<Map<String, List<T>>>> Function(String)?
        callbackCategoriesItems,
  }) {
    _openSearchDialog(
      callbackCategoriesItems: callbackCategoriesItems,
      onSingleSelected: onSingleSelected,
      buildDropdownItem: buildDropdownItem,
      currentItem: currentItem,
    );
  }

  static void openMultiSearchCategoriesDialog<T extends ISearchable>({
    required Widget Function(T) buildDropdownItem,
    Function(List<T>)? onMultiSelected,
    required List<T>? currentItems,
    required Widget Function(T)? buildChipItem,
    required Future<List<Map<String, List<T>>>> Function(String)?
        callbackCategoriesItems,
  }) {
    _openSearchDialog(
      onMultiSelected: onMultiSelected,
      buildDropdownItem: buildDropdownItem,
      items: currentItems,
      isMulti: true,
      buildChipItem: buildChipItem,
      callbackCategoriesItems: callbackCategoriesItems,
    );
  }

  static void _openSearchDialog<T extends ISearchable>({
    required Widget Function(T) buildDropdownItem,
    Future<List<T>> Function(String)? callbackItems,
    Future<List<Map<String, List<T>>>> Function(String)?
        callbackCategoriesItems,
    List<T>? items,
    Function(List<T>)? onMultiSelected,
    Function(T)? onSingleSelected,
    bool isMulti = false,
    Widget Function(T)? buildChipItem,
    T? currentItem,
    bool Function(T, String)? onFilter,
  }) {
    Get.lazyPut(
      () => SearchController<T>(
        items: items,
        onMultiSelected: onMultiSelected,
        onSingleSelected: onSingleSelected,
        isMulti: isMulti,
        currentItem: currentItem,
        callbackCategoriesItems: callbackCategoriesItems,
        onFilter: onFilter,
        callbackItems: callbackItems,
      ),
    );

    Get.dialog(
      SearchScreen<T>(
        buildDropdownItem: buildDropdownItem,
        buildChipItem: buildChipItem,
      ),
    );
  }

  static String listToStringItems({required Iterable<String> items}) {
    return items.toList().toString().replaceAll('[', '').replaceAll(']', '');
  }
}
