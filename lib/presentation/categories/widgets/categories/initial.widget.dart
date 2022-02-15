import 'package:flutter/material.dart';

import '../../../../domain/core/abstractions/presentation/controllers/categories/category_controller.interface.dart';
import '../../../shared/view_controller.interface.dart';

class InitialWidget extends ViewController<ICategoryController> {
  @override
  Widget build(BuildContext context) {
    return Text(controller.katekko);
  }
}
