import 'package:ekko/domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import 'package:ekko/presentation/shared/view_controller.interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class IconPickerWidget extends ViewController<ICategoryController> {
  void pickIcon(BuildContext context) async {
    final icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [IconPack.material],
      searchHintText: 'Procurar icone',
      title: const Text('Escolha um icone'),
      closeChild: const Text('Fechar', textScaleFactor: 1.25),
    );
    if (icon != null) controller.pickAnIcon(icon.codePoint);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<int>(
          stream: controller.iconFieldStream,
          builder: (_, snap) {
            return Card(
              shadowColor: snap.hasError ? Colors.red : null,
              color: snap.hasError ? Colors.red.shade100 : null,
              elevation: 3,
              child: SizedBox(
                height: 80,
                width: 80,
                child: snap.hasData
                    ? Icon(
                        IconData(snap.data!, fontFamily: 'MaterialIcons'),
                        size: 70,
                      )
                    : const SizedBox(),
              ),
            );
          },
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => pickIcon(context),
          child: const Text('Escolha um Icone'),
        ),
      ],
    );
  }
}
