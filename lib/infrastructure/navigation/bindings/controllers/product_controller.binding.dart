import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/builders/string_field_validator.builder.dart';
import 'package:ekko/domain/core/models/getx_field.model.dart';
import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import '../../../../presentation/products/controllers/controllers.dart';

class ProductControllerBinding extends Bindings {
  final bool isEdit;
  ProductControllerBinding({required this.isEdit});

  @override
  void dependencies() {
    Get.lazyPut<IProductController>(makeProductController);
  }
}

IField<String> makeProductNameField() {
  return GetxFieldModel(
    validators: StringFieldValidatorBuilder().required().build(),
  );
}

IProductController makeProductController() {
  return ProductController(
    nameField: makeProductNameField(),
  );
}
