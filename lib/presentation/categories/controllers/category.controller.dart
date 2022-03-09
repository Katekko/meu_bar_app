import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/table/models/category.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

import '../../../domain/core/abstractions/domain/repositories/category_repository.interface.dart';
import '../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../domain/core/abstractions/presentation/stream_field.interface.dart';

class CategoryController extends GetxController implements ICategoryController {
  late final ICategoryRepository _categoryRepository;
  late final bool _isEdit;
  late final IField<String> _nameField;
  late final IStreamField<int?> _iconField;
  late final ILoadingController _loading;
  late final CategoryModel? _category;

  CategoryController({
    required ICategoryRepository categoryRepository,
    required ILoadingController loading,
    required bool isEdit,
    required IField<String> nameField,
    required IStreamField<int?> iconField,
    CategoryModel? category,
  })  : _categoryRepository = categoryRepository,
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
  void onInit() {
    super.onInit();
    if (_category != null) {
      _nameField.value = _category!.name;
      _iconField.value = _category!.icon;
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
          name: _nameField.value!,
          icon: _iconField.value!,
        );

        if (isEdit) {
          await _categoryRepository.updateCategory(category);
        } else {
          await _categoryRepository.registerCategory(category);
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
