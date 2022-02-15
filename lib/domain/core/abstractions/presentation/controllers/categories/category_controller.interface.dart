import '../../field.interface.dart';

abstract class ICategoryController {
  bool get isEdit;
  IField get nameField;
  Stream<int> get iconFieldStream;

  void pickAnIcon(int hex);
  void createCategory({required void Function() backScreen});
}
