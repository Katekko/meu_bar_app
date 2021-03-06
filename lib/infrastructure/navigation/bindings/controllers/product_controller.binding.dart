import 'dart:typed_data';

import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/image_picker.interface.dart';
import 'package:ekko/domain/core/builders/field_validator.builder.dart';
import 'package:ekko/domain/core/models/getx_field.model.dart';
import 'package:ekko/domain/core/models/rx_field.model.dart';
import 'package:ekko/domain/table/models/category.model.dart';
import 'package:ekko/domain/table/models/product.model.dart';
import 'package:ekko/infrastructure/navigation/bindings/domains/product.repository.binding.dart';
import 'package:get/get.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';
import '../../../../presentation/products/controllers/controllers.dart';
import '../../../../presentation/shared/loading/loading.interface.dart';
import '../../../dal/inject.dart';
import '../domains/category.repository.binding.dart';

class ProductControllerBinding extends Bindings {
  final bool isEdit;
  ProductControllerBinding({required this.isEdit});

  @override
  void dependencies() {
    Get.lazyPut<IProductController>(
      () => makeProductController(isEdit: isEdit),
    );
  }
}

IField<String> makeProductNameField() {
  return GetxFieldModel(
    validators: FieldValidatorBuilder<String>().required().build(),
  );
}

IField<String> makeProductDescriptionField() {
  return GetxFieldModel();
}

IField<double> makeProductPriceField() {
  return GetxFieldModel<double>(
    validators: FieldValidatorBuilder<double>().required().build(),
  );
}

RxFieldModel<CategoryModel> makeProductCategoryField() {
  return RxFieldModel<CategoryModel>(
    validators: FieldValidatorBuilder<CategoryModel>().required().build(),
  );
}

RxFieldModel<Uint8List> makeProductImageBytesField() {
  return RxFieldModel<Uint8List>(
    validators: FieldValidatorBuilder<Uint8List>().build(),
  );
}

IProductController makeProductController({required bool isEdit}) {
  final arguments = Get.arguments as Map<String, dynamic>?;

  ProductModel? product;
  if (arguments != null) {
    product = arguments['product'];
  }

  final imagePicker = Inject.find<IImagePicker>();

  return ProductController(
    productRepository: ProductRepositoryBinding().repository,
    categoryRepository: CategoryRepositoryBinding().repository,
    imagePicker: imagePicker,
    loading: Inject.find<ILoadingController>(),
    isEdit: isEdit,
    nameField: makeProductNameField(),
    descriptionField: makeProductDescriptionField(),
    categoryField: makeProductCategoryField(),
    priceField: makeProductPriceField(),
    imageBytesField: makeProductImageBytesField(),
    product: product,
  );
}
