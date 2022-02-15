import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';

import '../../reactive_button.interface.dart';

abstract class ILoginController implements IReactiveButton {
  IField get currentLogin;
  IField get currentPassword;

  Future<void> doLogin({
    required void Function() navigateToHome,
    required void Function(String) onUserOrPasswordNotExists,
    required void Function(String) onError,
  });
}
