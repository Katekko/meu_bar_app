import 'dart:async';

import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController
    implements ICategoriesController {
  final IProductRepository _productRepository;
  final ILoadingController _loading;
  final _categories = StreamController<List<CategoryModel>>();

  CategoriesController({
    required IProductRepository productRepository,
    required ILoadingController loading,
  })  : _productRepository = productRepository,
        _loading = loading;

  @override
  Stream<List<CategoryModel>> get categories => _categories.stream;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  @override
  void onClose() {
    _categories.close();
    super.onClose();
  }

  @override
  void loadCategories() async {
    try {
      _loading.isLoading = true;
      final response = await _productRepository.getCategories();
      _categories.add(response);
    } catch (err) {
      _categories.addError(err);
    } finally {
      _loading.isLoading = false;
    }
  }

  @override
  void createCategory({required Future<void> Function() openScreen}) async {
    await openScreen();
    loadCategories();
  }

  @override
  void editCategory({
    required CategoryModel category,
    required void Function(CategoryModel category) openScreen,
  }) {
    openScreen(category);
  }
}
