import 'package:flutter/material.dart';

import '../../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';
import '../../../shared/view_controller.interface.dart';

class InitialWidget extends ViewController<IProductsController> {
  @override
  Widget build(BuildContext context) {
    return Text(controller.katekko);
  }
}
