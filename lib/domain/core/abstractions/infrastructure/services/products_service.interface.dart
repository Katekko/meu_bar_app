import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

abstract class IProductsService {
  Future<List<ProductData>> getProducts({String? filter});
}
