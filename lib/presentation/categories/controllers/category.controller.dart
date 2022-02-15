import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';

import '../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../domain/core/abstractions/rx.dart';

class CategoryController implements ICategoryController {
  late final IProductRepository _productRepository;
  late final bool _isEdit;
  late final IField _nameField;
  late final ILoadingController _loading;

  CategoryController({
    required IProductRepository productRepository,
    required ILoadingController loading,
    required bool isEdit,
    required IField nameField,
  })  : _productRepository = productRepository,
        _loading = loading,
        _isEdit = isEdit,
        _nameField = nameField;

  final _iconField = Rx<int>();

  @override
  bool get isEdit => _isEdit;

  @override
  IField get nameField => _nameField;

  @override
  Stream<int> get iconFieldStream => _iconField.stream;

  @override
  void pickAnIcon(int hex) => _iconField.add(hex);

  @override
  void createCategory({required void Function() backScreen}) async {
    try {
      _loading.isLoading = true;

      if (validateFields()) {
        final category = CategoryModel(
          id: -1,
          name: _nameField.value,
          icon: _iconField.value,
        );

        await _productRepository.registerCategory(category);

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
    if (!_iconField.hasValue) {
      _iconField.addError('Icone Obrigatório');
    }

    return !_iconField.hasError && !_nameField.hasError;
  }
}
