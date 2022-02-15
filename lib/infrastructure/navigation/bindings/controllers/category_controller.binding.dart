import 'package:ekko/domain/core/builders/field_validator.builder.dart';
import 'package:ekko/domain/core/models/getx_field.model.dart';
import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../../domain/core/abstractions/presentation/field.interface.dart';
import '../../../../presentation/categories/controllers/controllers.dart';

class CategoryControllerBinding extends Bindings {
  final bool isEdit;
  CategoryControllerBinding({required this.isEdit});

  @override
  void dependencies() {
    Get.lazyPut<ICategoryController>(
      () => makeCategoryController(
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
  required bool isEdit,
  required IField nameField,
}) {
  return CategoryController(isEdit: isEdit, nameField: nameField);
}
