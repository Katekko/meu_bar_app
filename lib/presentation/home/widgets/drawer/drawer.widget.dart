import 'package:ekko/domain/core/abstractions/presentation/controllers/home/home_controller.interface.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../shared/view_controller.interface.dart';
import 'exit_button.widget.dart';
import 'header.widget.dart';
import 'menu_item.widget.dart';

class DrawerWidget extends ViewController<IHomeController> {
  void navToCategories(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.categories);
  }

  void navToProducts(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(),
            const Divider(color: Color(0xFFC4C4C4)),
            MenuItemWidget(
              text: 'Categorias',
              icon: Icons.category,
              onTap: () => navToCategories(context),
            ),
            MenuItemWidget(
              text: 'Produtos',
              icon: Icons.production_quantity_limits,
              onTap: () => navToProducts(context),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(14),
              child: _RodapeWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class _RodapeWidget extends ViewController<IHomeController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ExitButtonWidget(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StreamBuilder<String>(
              stream: controller.currentVersionStream,
              builder: (_, versionSnap) {
                return Text(
                  'Versão: ${versionSnap.data}',
                  style: const TextStyle(
                    color: Color(0xFFC4C4C4),
                    fontSize: 12,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
