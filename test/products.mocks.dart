import 'package:ekko/domain/product/models/category.model.dart';
import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

const categoryData1 = CategoryData(id: 1, name: 'Bebidas', icon: 0xff);
const categoryData2 = CategoryData(id: 2, name: 'Comidas', icon: 0xff);
const categoryData3 = CategoryData(id: 2, name: 'Outros', icon: 0xff);

const listCategoriesData = [categoryData1, categoryData2, categoryData3];

const productData1 = ProductData(
  id: 1,
  name: 'Amstel 600',
  category: categoryData1,
  urlImage: null,
  price: 10,
);

const productData2 = ProductData(
  id: 2,
  name: 'Petra 600',
  category: categoryData2,
  urlImage: null,
  price: 12,
);

final listProductsData = [productData1, productData2];

//-------------------------------------------------------------------------------//

const categoryModel1 = CategoryModel(id: 1, name: 'Bebidas', icon: 0xff);
const categoryModel2 = CategoryModel(id: 2, name: 'Comidas', icon: 0xff);
const categoryModel3 = CategoryModel(id: 2, name: 'Outros', icon: 0xff);

const listCategoriesModel = [categoryModel1, categoryModel2, categoryModel3];

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
