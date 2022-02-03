import 'package:ekko/domain/core/abstractions/presentation/controllers/login/login_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';

class LoginTextFieldWidget extends ViewController<ILoginController> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: controller.currentLogin.errorStream,
      builder: (_, snapshot) {
        return TextFormField(
          onChanged: controller.currentLogin.onChange,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: snapshot.hasData ? snapshot.data as String : null,
            hintText: 'Login',
          ),
        );
      },
    );
  }
}
