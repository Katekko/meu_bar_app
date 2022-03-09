import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/table/models/product.mock.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

import '../data/category.data.dart';

class ProductsMockService implements IProductsService {
  @override
  Future<List<ProductData>> getProducts({
    String? filter,
    List<CategoryData>? categories,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listProductsData;
  }

  @override
  Future<void> createProduct(ProductData body) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listProductsData.add(body);
  }

  @override
  Future<void> updateProduct(ProductData body) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final index = listProductsData.indexWhere((e) => e.id == body.id);
    listProductsData[index] = body;
  }

  @override
  Future<void> deleteProduct(ProductData body) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listProductsData.removeWhere((e) => body.id == e.id);
  }

  @override
  Future<ProductData> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listProductsData.firstWhere((e) => e.id == id);
  }
}
