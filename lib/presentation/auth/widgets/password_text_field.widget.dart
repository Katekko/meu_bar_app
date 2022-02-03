import 'package:ekko/domain/core/abstractions/presentation/controllers/login/login_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends ViewController<ILoginController> {
  final void Function(BuildContext) doLogin;
  const PasswordTextFieldWidget(this.doLogin);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: controller.currentPassword.errorStream,
      builder: (_, snapshot) {
        return TextFormField(
          onChanged: controller.currentPassword.onChange,
          textAlign: TextAlign.center,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => doLogin(context),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: snapshot.hasData ? snapshot.data : null,
            hintText: 'Password',
          ),
        );
      },
    );
  }
}
