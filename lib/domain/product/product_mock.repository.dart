import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/domain/product/models/category.model.dart';

const categoryModel1 = CategoryModel(id: 1, name: 'Bebidas', icon: 0xe6f1);
const categoryModel2 = CategoryModel(id: 2, name: 'Comidas', icon: 0xe532);
const categoryModel3 = CategoryModel(id: 2, name: 'Outros', icon: 0xe147);

final listCategoriesModel = [categoryModel1, categoryModel2, categoryModel3];

const productModel1 = ProductModel(
  id: 1,
  name: 'Amstel 600',
  category: categoryModel1,
  urlImage: null,
  price: 10,
);

const productModel2 = ProductModel(
  id: 2,
  name: 'Petra 600',
  category: categoryModel2,
  urlImage: null,
  price: 12,
);

final listProductsModel = [productModel1, productModel2];

class ProductMockRepository implements IProductRepository {
  @override
  Future<List<CategoryModel>> getCategories({String? filter}) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listCategoriesModel;
  }

  @override
  Future<void> deleteCategory(CategoryModel category) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listCategoriesModel.removeWhere((e) => category.id == e.id);
  }

  @override
  Future<void> deleteProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listProductsModel.removeWhere((e) => product.id == e.id);
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return listCategoriesModel.firstWhere((e) => e.id == id);
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
  Future<void> registerCategory(CategoryModel category) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listCategoriesModel.add(category);
  }

  @override
  Future<void> registerProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 700));
    listProductsModel.add(product);
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final index = listCategoriesModel.indexWhere((e) => e.id == category.id);
    listCategoriesModel[index] = category;
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final index = listProductsModel.indexWhere((e) => e.id == product.id);
    listProductsModel[index] = product;
  }
}
