import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

import '../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../domain/core/abstractions/presentation/stream_field.interface.dart';

class CategoryController extends GetxController implements ICategoryController {
  late final IProductRepository _productRepository;
  late final bool _isEdit;
  late final IField<String> _nameField;
  late final IStreamField<int?> _iconField;
  late final ILoadingController _loading;
  late final CategoryModel? _category;

  CategoryController({
    required IProductRepository productRepository,
    required ILoadingController loading,
    required bool isEdit,
    required IField<String> nameField,
    required IStreamField<int?> iconField,
    CategoryModel? category,
  })  : _productRepository = productRepository,
        _loading = loading,
        _isEdit = isEdit,
        _nameField = nameField,
        _iconField = iconField,
        _category = category;

  @override
  bool get isEdit => _isEdit;

  @override
  IField<String> get nameField => _nameField;

  @override
  IStreamField<int?> get iconField => _iconField;

  @override
  void onInit() async {
    super.onInit();
    if (_category != null) {
      _nameField.value = _category!.name;
      Future.delayed(const Duration(milliseconds: 200), () {
        _iconField.value = _category!.icon;
      });
    }
  }

  @override
  void onClose() {
    _nameField.dispose();
    _iconField.dispose();
    super.onClose();
  }

  @override
  Future<void> saveCategory({required void Function() backScreen}) async {
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

  @override
  bool validateFields() {
    _nameField.validate();
    _iconField.validate();

    return !_nameField.hasError && !_iconField.hasError;
  }
}
