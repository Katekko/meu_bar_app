import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';

import '../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';

class CategoryController implements ICategoryController {
  late final bool _isEdit;
  late final IField _nameField;

  CategoryController({
    required bool isEdit,
    required IField nameField,
  })  : _isEdit = isEdit,
        _nameField = nameField;

  @override
  bool get isEdit => _isEdit;

  @override
  IField get nameField => _nameField;
}
