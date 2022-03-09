import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/table/models/product.model.dart';
import 'package:ekko/domain/table/models/category.model.dart';

final categoryModel1 = CategoryModel(id: 1, name: 'Bebidas', icon: 0xe6f1);
final categoryModel2 = CategoryModel(id: 2, name: 'Comidas', icon: 0xe532);
final categoryModel3 = CategoryModel(id: 3, name: 'Outros', icon: 0xe147);

final listCategoriesModel = [categoryModel1, categoryModel2, categoryModel3];

final productModel1 = ProductModel(
  id: 1,
  name: 'Amstel 600',
  category: categoryModel1,
  urlImage: 'https://10619-2.s.cdn12.com/rests/original/344_508581564.jpg',
  price: 10.56,
);

final productModel2 = ProductModel(
  id: 2,
  name: 'Petra 600',
  category: categoryModel2,
  urlImage:
      'https://instadelivery-public.nyc3.digitaloceanspaces.com/itens/163801540561a221adb2cea_75_75.jpeg',
  price: 12,
  description:
      'Cerveja petra gelada boa de mais, vamos colocar uma descrição maior para ver como vai se comportar',
);

final listProductsModel = [productModel1, productModel2];

class ProductMockRepository implements IProductRepository {
  @override
  Future<void> deleteProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listProductsModel.removeWhere((e) => product.id == e.id);
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listProductsModel.firstWhere((e) => e.id == id);
  }

  @override
  Future<List<ProductModel>> getProducts({
    String? filter,
    List<CategoryModel>? categories,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listProductsModel;
  }

  @override
  Future<void> registerProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listProductsModel.add(product);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final index = listProductsModel.indexWhere((e) => e.id == product.id);
    listProductsModel[index] = product;
  }
}
