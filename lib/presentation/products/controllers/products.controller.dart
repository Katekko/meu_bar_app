import '../../../domain/core/abstractions/presentation/controllers/products/products_controller.interface.dart';

class ProductsController implements IProductsController {
  //TODO: Implement ProductsController

  final _katekko = 'katekko';

  @override
  String get katekko => _katekko;
}
