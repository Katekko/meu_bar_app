import 'package:ekko/domain/core/abstractions/domain/repositories/auth_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/login/login_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/builders/field_validator.builder.dart';
import 'package:ekko/domain/core/models/getx_field.model.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/infrastructure/navigation/bindings/domains/auth.repository.binding.dart';
import 'package:ekko/presentation/auth/controllers/controllers.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    final authBinding = AuthRepositoryBinding();
    final loading = Inject.find<ILoadingController>();

    Inject.put<ILoginController>(
      () => makeLoginController(
        authRepository: authBinding.repository,
        loading: loading,
      ),
    );
  }
}

IField makeLoginField() {
  return GetxFieldModel(
    value: '',
    validators: FieldValidatorBuilder().required().build(),
  );
}

IField makePasswordField() {
  return GetxFieldModel(
    value: '',
    validators: FieldValidatorBuilder().required().password().build(),
  );
}

ILoginController makeLoginController({
  required IAuthRepository authRepository,
  required ILoadingController loading,
}) {
  return LoginController(
    authRepository: authRepository,
    loading: loading,
    login: makeLoginField(),
    password: makePasswordField(),
  );
}
