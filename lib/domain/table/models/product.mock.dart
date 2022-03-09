import 'package:ekko/domain/table/models/product.model.dart';
import 'package:ekko/infrastructure/dal/services/data/product.data.dart';

import 'category.mock.dart';

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

final productModel1 = ProductModel(
  id: 1,
  name: 'Amstel 600',
  category: categoryModel1,
  urlImage: null,
  price: 10,
);

final productModel2 = ProductModel(
  id: 2,
  name: 'Petra 600',
  category: categoryModel2,
  urlImage: null,
  price: 12,
);

final listProductsModel = [productModel1, productModel2];
