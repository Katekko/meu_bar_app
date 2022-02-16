import '../../field.interface.dart';

abstract class ICategoryController {
  bool get isEdit;
  IField get nameField;

  Stream<int?> get iconFieldStream;

  void pickAnIcon(int hex);
  void saveCategory({required void Function() backScreen});
}
