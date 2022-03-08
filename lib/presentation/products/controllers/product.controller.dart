import 'dart:async';
import 'dart:typed_data';

import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/stream_field.interface.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

import '../../../domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';

class ProductController extends GetxController implements IProductController {
  final IProductRepository _productRepository;
  final ILoadingController _loading;

  final bool _isEdit;
  final IField<String> _nameField;
  final IField<String> _descriptionField;
  final IField<double> _priceField;
  final IStreamField<CategoryModel?> _categoryField;
  final IStreamField<Uint8List?> _imageBytesField;

  final ProductModel? _product;

  ProductController({
    required IProductRepository productRepository,
    required ILoadingController loading,
    required bool isEdit,
    required IField<String> nameField,
    required IField<String> descriptionField,
    required IField<double> priceField,
    required IStreamField<CategoryModel?> categoryField,
    required IStreamField<Uint8List?> imageBytesField,
    ProductModel? product,
  })  : _productRepository = productRepository,
        _loading = loading,
        _isEdit = isEdit,
        _nameField = nameField,
        _descriptionField = descriptionField,
        _priceField = priceField,
        _categoryField = categoryField,
        _imageBytesField = imageBytesField,
        _product = product;

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
  String? get urlImage => _product?.urlImage;

  @override
  void onInit() {
    super.onInit();
    assert(
      _isEdit && _product != null,
      'Necessário passar o produto para entrar em modo de edição',
    );
    if (_product != null) {
      _nameField.value = _product!.name;
      _descriptionField.value = _product!.description;
      _priceField.value = _product!.price;
      _categoryField.value = _product!.category;
      _imageBytesField.value = _product!.imageBytes;
    }
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
  Future<void> saveProduct({
    required void Function() backScreen,
    required void Function(dynamic err) onError,
  }) async {
    try {
      _loading.isLoading = true;
      if (validateFields()) {
        final product = ProductModel(
          id: _isEdit ? _product!.id : -1,
          name: _nameField.value!,
          price: _priceField.value!,
          category: _categoryField.value!,
          description: _descriptionField.value,
        );

        if (_isEdit) {
          await _productRepository.updateProduct(product);
        } else {
          await _productRepository.registerProduct(product);
        }

        backScreen();
      }
    } catch (err) {
      onError(err);
    } finally {
      _loading.isLoading = false;
    }
  }

  @override
  Future<List<CategoryModel>> loadCategories(String term) async {
    try {
      final response = await _productRepository.getCategories(filter: term);
      return response;
    } catch (err) {
      rethrow;
    }
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
