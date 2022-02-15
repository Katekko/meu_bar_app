import 'dart:async';

import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/categories_controller.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController
    implements ICategoriesController {
  final IProductRepository _productRepository;
  final _categories = StreamController<List<CategoryModel>>();

  CategoriesController({required IProductRepository productRepository})
      : _productRepository = productRepository;

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
      final response = await _productRepository.getCategories();
      _categories.add(response);
    } catch (err) {
      _categories.addError(err);
    }
  }

  @override
  void createCategory({required void Function() openScreen}) {
    openScreen();
  }

  @override
  void editCategory({
    required CategoryModel category,
    required void Function(CategoryModel category) openScreen,
  }) {
    openScreen(category);
  }
}
