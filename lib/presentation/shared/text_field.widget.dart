import 'package:flutter/material.dart';

import '../../domain/core/abstractions/presentation/field.interface.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final IField field;
  const TextFieldWidget({required this.label, required this.field});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: field.errorStream,
      builder: (_, snapshot) {
        return TextFormField(
          onChanged: field.onChange,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorText: snapshot.hasData ? snapshot.data as String : null,
            label: Text(label),
          ),
        );
      },
    );
  }
}
