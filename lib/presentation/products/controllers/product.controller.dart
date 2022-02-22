import 'dart:async';
import 'dart:typed_data';

import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:get/get.dart';

import '../../../domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';

class ProductController extends GetxController implements IProductController {
  final bool _isEdit;
  final IField<String> _nameField;
  final IField<String> _descriptionField;
  final IStreamField<CategoryModel?> _categoryField;

  ProductController({
    required bool isEdit,
    required IField<String> nameField,
    required IField<String> descriptionField,
    required IStreamField<CategoryModel?> categoryField,
  })  : _isEdit = isEdit,
        _nameField = nameField,
        _descriptionField = descriptionField,
        _categoryField = categoryField;

  @override
  bool get isEdit => _isEdit;

  @override
  IField<String> get nameField => _nameField;

  @override
  IField<String> get descriptionField => _descriptionField;

  @override
  IStreamField<CategoryModel?> get categoryField => _categoryField;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    _nameField.dispose();
    _descriptionField.dispose();
    _categoryField.dispose();
    super.onClose();
  }

  @override
  // TODO: implement imageBytesField
  IStreamField<Uint8List?> get imageBytesField => throw UnimplementedError();

  @override
  // TODO: implement priceField
  IField<double> get priceField => throw UnimplementedError();

  @override
  Future<void> saveProduct({required void Function() backScreen}) {
    // TODO: implement saveProduct
    throw UnimplementedError();
  }

  @override
  bool validateFields() {
    _nameField.validate();
    _descriptionField.validate();
    _categoryField.validate();

    return !_nameField.hasError &&
        !_descriptionField.hasError &&
        !_categoryField.hasError;
  }
}
