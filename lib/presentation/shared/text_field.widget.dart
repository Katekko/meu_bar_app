import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../../domain/core/abstractions/presentation/field.interface.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final IField field;
  final bool isCurrency;
  const TextFieldWidget({
    required this.label,
    required this.field,
    this.isCurrency = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: field.errorStream,
      builder: (_, snapshot) {
        return TextFormField(
          initialValue: field.value.toString(),
          onChanged: field.onChange,
          textInputAction: TextInputAction.next,
          keyboardType: isCurrency ? TextInputType.number : TextInputType.text,
          inputFormatters: [
            if (isCurrency) CurrencyTextInputFormatter(symbol: 'R\$ '),
          ],
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
