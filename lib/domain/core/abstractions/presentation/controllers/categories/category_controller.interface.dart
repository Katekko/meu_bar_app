import '../../field.interface.dart';
import '../../stream_field.interface.dart';

abstract class ICategoryController {
  bool get isEdit;
  IField<String> get nameField;
  IStreamField<int?> get iconField;

  void pickAnIcon(int hex);
  Future<void> saveCategory({required void Function() backScreen});
  bool validateFields();

  void onClose();
}
