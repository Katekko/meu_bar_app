import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/builders/field_validator.builder.dart';
import 'package:ekko/domain/core/models/getx_field.model.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/infrastructure/navigation/bindings/domains/product.repository.binding.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../../domain/core/abstractions/presentation/field.interface.dart';
import '../../../../presentation/categories/controllers/controllers.dart';
import '../../../dal/inject.dart';

class CategoryControllerBinding extends Bindings {
  final bool isEdit;
  CategoryControllerBinding({required this.isEdit});

  @override
  void dependencies() {
    final productBinding = ProductRepositoryBinding();
    Get.lazyPut<ICategoryController>(
      () => makeCategoryController(
        productRepository: productBinding.repository,
        loading: Inject.find<ILoadingController>(),
        isEdit: isEdit,
        nameField: makeCategoryNameField(),
      ),
    );
  }
}

IField makeCategoryNameField() {
  return GetxFieldModel(
    value: '',
    validators: FieldValidatorBuilder().required().build(),
  );
}

ICategoryController makeCategoryController({
  required IProductRepository productRepository,
  required ILoadingController loading,
  required bool isEdit,
  required IField nameField,
}) {
  final arguments = Get.arguments as Map<String, dynamic>?;

  CategoryModel? category;
  if (arguments != null) {
    category = arguments['category'];
  }

  return CategoryController(
    productRepository: productRepository,
    loading: loading,
    isEdit: isEdit,
    nameField: nameField,
    category: category,
  );
}
