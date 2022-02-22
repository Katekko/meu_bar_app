import 'dart:async';

import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesController extends GetxController
    implements ICategoriesController {
  final IProductRepository _productRepository;
  final ILoadingController _loading;

  CategoriesController({
    required IProductRepository productRepository,
    required ILoadingController loading,
  })  : _productRepository = productRepository,
        _loading = loading;

  final _categoriesStream = BehaviorSubject<List<CategoryModel>>();

  @override
  Stream<List<CategoryModel>> get categoriesStream => _categoriesStream.stream;

  @override
  bool get categoriesStreamIsClosed => _categoriesStream.isClosed;

  @override
  Future<void> onReady() async {
    super.onReady();
    loadCategories(withLoad: false);
  }

  @override
  void onClose() {
    _categoriesStream.close();
    super.onClose();
  }

  @override
  Future<void> loadCategories({bool withLoad = true}) async {
    try {
      if (withLoad) _loading.isLoading = true;
      final response = await _productRepository.getCategories();
      _categoriesStream.add(response);
    } catch (err) {
      _categoriesStream.addError(err);
    } finally {
      if (withLoad) _loading.isLoading = false;
    }
  }

  @override
  Future<void> createCategory({
    required Future<void> Function() openScreen,
  }) async {
    await openScreen();
    loadCategories();
  }

  @override
  Future<void> editCategory({
    required CategoryModel category,
    required Future<void> Function(CategoryModel category) openScreen,
  }) async {
    await openScreen(category);
    loadCategories();
  }
}
