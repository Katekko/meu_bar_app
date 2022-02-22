import '../../../domain/core/abstractions/presentation/controllers/products/product_controller.interface.dart';

class ProductController implements IProductController {
  //TODO: Implement ProductController

  final _katekko = 'katekko';

  @override
  String get katekko => _katekko;
}
