import 'package:ekko/domain/product/models/category.model.dart';

import '../../field.interface.dart';

abstract class ICategoryController {
  bool get isEdit;
  IField get nameField;
  Stream<int> get iconFieldStream;

  void pickAnIcon(int hex);
}
