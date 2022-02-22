import 'dart:async';
import 'dart:typed_data';

import 'package:ekko/domain/product/models/category.model.dart';

import '../../field.interface.dart';
import '../../stream_field.interface.dart';

abstract class IProductController {
  bool get isEdit;
  IField<String> get nameField;
  IField<String> get descriptionField;
  IField<double> get priceField;
  IStreamField<Uint8List?> get imageBytesField;
  IStreamField<CategoryModel?> get categoryField;

  Future<void> saveProduct({required void Function() backScreen});
  bool validateFields();

  FutureOr onInit();
  FutureOr onClose();
}