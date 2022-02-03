import 'package:ekko/domain/core/abstractions/presentation/controllers/login/login_controller.interface.dart';
import 'package:ekko/domain/core/utils/snackbar.util.dart';
import 'package:ekko/infrastructure/navigation/routes.dart';
import 'package:ekko/presentation/shared/hide_keyboard/hide_keyboard.widget.dart';
import 'package:ekko/presentation/shared/loading/loading.widget.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/login_button.widget.dart';
import '../../widgets/login_text_field.widget.dart';
import '../../widgets/password_text_field.widget.dart';

class LoginScreen extends ViewController<ILoginController> {
  void doLogin(BuildContext context) {
    FocusScope.of(context).unfocus();
    controller.doLogin(
      navigateToHome: () => Navigator.of(context).popAndPushNamed(Routes.home),
      onUserOrPasswordNotExists: SnackbarUtil.showWarning,
      onError: SnackbarUtil.showError,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: HideKeyboardWidget(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('EKKO APP', style: Get.textTheme.headline3),
                      const SizedBox(height: 50),
                      LoginTextFieldWidget(),
                      const SizedBox(height: 10),
                      PasswordTextFieldWidget(doLogin),
                      const SizedBox(height: 20),
                      LoginButtonWidget(doLogin),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
