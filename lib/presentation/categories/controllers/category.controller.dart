import '../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';

class CategoryController implements ICategoryController {
  late final bool _isEdit;
  CategoryController({required bool isEdit}) : _isEdit = isEdit;

  @override
  bool get isEdit => _isEdit;

  final _katekko = 'katekko';

  @override
  String get katekko => _katekko;
}
