import 'package:ekko/domain/core/abstractions/domain/repositories/auth_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/controllers/login/login_controller.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/domain/core/exceptions/user_or_password_wrong.exception.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:get/get.dart';

class LoginController implements ILoginController {
  final IAuthRepository _authRepository;
  final ILoadingController _loading;
  final IField _login;
  final IField _password;

  LoginController({
    required IAuthRepository authRepository,
    required ILoadingController loading,
    required IField login,
    required IField password,
  })  : _authRepository = authRepository,
        _loading = loading,
        _login = login,
        _password = password {
    _login.onChangeCallback = (_) => buttonEnabled;
    _password.onChangeCallback = (_) => buttonEnabled;
  }

  final _buttonEnabled = false.obs;

  @override
  IField get currentLogin => _login;

  @override
  IField get currentPassword => _password;

  @override
  Stream<bool> get buttonEnabledStream => _buttonEnabled.stream;

  @override
  Future<void> doLogin({
    required void Function() navigateToHome,
    required void Function(String) onUserOrPasswordNotExists,
    required void Function(String) onError,
  }) async {
    try {
      _loading.isLoading = true;
      if (buttonEnabled) {
        await _authRepository.authenticateUser(
          login: _login.value,
          password: _password.value,
        );

        navigateToHome();
      }
    } on UserOrPasswordWrongException catch (err) {
      onUserOrPasswordNotExists(err.toString());
    } catch (err) {
      onError(err.toString());
      rethrow;
    } finally {
      _loading.isLoading = false;
    }
  }

  @override
  bool get buttonEnabled {
    return _buttonEnabled.value = !_login.hasError &&
        _login.value.isNotEmpty &&
        !_password.hasError &&
        _password.value.isNotEmpty;
  }
}
