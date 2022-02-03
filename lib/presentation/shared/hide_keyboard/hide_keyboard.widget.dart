import 'package:flutter/material.dart';

class HideKeyboardWidget extends StatelessWidget {
  final Widget child;
  const HideKeyboardWidget({required this.child});

  void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => hideKeyboard(context),
        child: child,
      );
}
