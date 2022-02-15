import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';

class CategoryController extends GetxController implements ICategoryController {
  late final IProductRepository _productRepository;
  late final bool _isEdit;
  late final IField _nameField;
  late final ILoadingController _loading;
  late final CategoryModel? _category;

  CategoryController({
    required IProductRepository productRepository,
    required ILoadingController loading,
    required bool isEdit,
    required IField nameField,
    CategoryModel? category,
  })  : _productRepository = productRepository,
        _loading = loading,
        _isEdit = isEdit,
        _nameField = nameField,
        _category = category;

  final _iconField = Rxn<int>();
  final _iconFieldError = Rxn<String>();

  @override
  bool get isEdit => _isEdit;

  @override
  IField get nameField => _nameField;

  @override
  Stream<int?> get iconFieldStream => _iconField.stream;
  @override
  Stream<String?> get iconFieldError => _iconFieldError.stream;

  @override
  void onInit() async {
    super.onInit();
    if (_category != null) {
      /// TODO: Esperando versão 5.0 do getx
      _nameField.value = _category!.name;
      Future.delayed(const Duration(milliseconds: 200), () {
        _iconField.value = _category!.icon;
      });
    }
  }

  @override
  void onClose() {
    _nameField.dispose();
    _iconField.close();
    super.onClose();
  }

  @override
  void pickAnIcon(int hex) {
    _iconField.value = hex;
    _iconFieldError.value = null;
  }

  @override
  void saveCategory({required void Function() backScreen}) async {
    try {
      _loading.isLoading = true;

      if (validateFields()) {
        final category = CategoryModel(
          id: isEdit ? _category!.id : -1,
          name: _nameField.value,
          icon: _iconField.value!,
        );

        if (isEdit) {
          await _productRepository.updateCategory(category);
        } else {
          await _productRepository.registerCategory(category);
        }

        backScreen();
      }
    } catch (err) {
      rethrow;
    } finally {
      _loading.isLoading = false;
    }
  }

  bool validateFields() {
    _nameField.validate();

    _iconFieldError.value =
        _iconField.value == null ? 'Icone Obrigatório' : null;

    return !_nameField.hasError &&
        _iconFieldError.value == null &&
        _iconField.value != null;
  }
}
