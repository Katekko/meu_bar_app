import 'package:ekko/domain/core/validators/required_field.validator.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:test/test.dart';

import '../../../../mocks.dart';

void main() {
  setUpAll(() {
    Inject.put<ILoadingController>(() => LoadingControllerMock());
  });

  test('Should return the correct controller', () {
    final controller = makeProductController(isEdit: false);
    expect(
      controller.nameField.validators,
      [RequiredFieldValidator<String>()],
    );

    expect(
      controller.descriptionField.validators,
      [],
    );

    expect(controller.categoryField.validators,
        [RequiredFieldValidator<CategoryModel>()]);
  });
}
