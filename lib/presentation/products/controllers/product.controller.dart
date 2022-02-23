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
  final IField<double> _priceField;
  final IStreamField<CategoryModel?> _categoryField;
  final IStreamField<Uint8List?> _imageBytesField;

  ProductController({
    required bool isEdit,
    required IField<String> nameField,
    required IField<String> descriptionField,
    required IField<double> priceField,
    required IStreamField<CategoryModel?> categoryField,
    required IStreamField<Uint8List?> imageBytesField,
  })  : _isEdit = isEdit,
        _nameField = nameField,
        _descriptionField = descriptionField,
        _priceField = priceField,
        _categoryField = categoryField,
        _imageBytesField = imageBytesField;

  @override
  bool get isEdit => _isEdit;

  @override
  IField<String> get nameField => _nameField;

  @override
  IField<String> get descriptionField => _descriptionField;

  @override
  IField<double> get priceField => _priceField;

  @override
  IStreamField<CategoryModel?> get categoryField => _categoryField;

  @override
  IStreamField<Uint8List?> get imageBytesField => _imageBytesField;

  @override
  // ignore: unnecessary_overrides
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    _nameField.dispose();
    _descriptionField.dispose();
    _priceField.dispose();
    _categoryField.dispose();
    _imageBytesField.dispose();
    super.onClose();
  }

  @override
  Future<void> saveProduct({required void Function() backScreen}) {
    // TODO: implement saveProduct
    throw UnimplementedError();
  }

  @override
  bool validateFields() {
    _nameField.validate();
    _descriptionField.validate();
    _priceField.validate();
    _categoryField.validate();
    _imageBytesField.validate();

    return !_nameField.hasError &&
        !_descriptionField.hasError &&
        !_priceField.hasError &&
        !_categoryField.hasError &&
        !_imageBytesField.hasError;
  }
}
