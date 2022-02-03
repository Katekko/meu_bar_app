import 'package:ekko/domain/core/abstractions/presentation/controllers/login/login_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

class LoginButtonWidget extends ViewController<ILoginController> {
  final void Function(BuildContext) doLogin;
  const LoginButtonWidget(this.doLogin);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: controller.buttonEnabledStream,
      builder: (_, snapshot) {
        var buttonEnabled = snapshot.hasData && snapshot.data!;
        return ElevatedButton(
          onPressed: buttonEnabled ? () => doLogin(context) : null,
          child: const SizedBox(
            height: 60,
            width: double.infinity,
            child: Center(
              child: Text(
                'ENTER',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        );
      },
    );
  }
}
