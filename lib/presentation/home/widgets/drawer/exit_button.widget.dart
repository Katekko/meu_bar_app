import 'package:ekko/domain/core/abstractions/presentation/controllers/home/home_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../shared/view_controller.interface.dart';

class ExitButtonWidget extends ViewController<IHomeController> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: controller.logout,
      icon: const Icon(Icons.exit_to_app),
      label: const Text(
        'Sair',
        style: TextStyle(color: Color(0xFF7A7F85), fontSize: 18),
      ),
    );
  }
}
