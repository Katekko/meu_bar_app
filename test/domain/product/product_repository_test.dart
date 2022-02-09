import 'package:ekko/domain/core/abstractions/domain/repositories/product_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/products_service.interface.dart';
import 'package:ekko/domain/product/models/product.model.dart';
import 'package:ekko/domain/product/models/category.model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks.dart';
import '../../products.mocks.dart';

class ProductRepository implements IProductRepository {
  final IProductsService _productsService;
  ProductRepository({required IProductsService productsService})
      : _productsService = productsService;

  @override
  Future<List<ProductModel>> getProducts({
    String? filter,
    List<CategoryModel>? categories,
  }) async {
    try {
      final filterCategories = categories?.map((e) => e.toData()).toList();

      final response = await _productsService.getProducts(
        filter: filter,
        categories: filterCategories,
      );

      final models = response.map((e) => ProductModel.fromData(e)).toList();
      return models;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> registerProduct(ProductModel product) async {
    try {
      final data = product.toData();
      await _productsService.createProduct(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final data = product.toData();
      await _productsService.updateProduct(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(ProductModel product) async {
    try {
      final data = product.toData();
      await _productsService.deleteProduct(data);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _productsService.getProductById(id);
      final model = ProductModel.fromData(response);
      return model;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCategory(CategoryModel category) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> getCategories({String? filter}) {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> getCategoryById(int id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Future<void> registerCategory(CategoryModel category) {
    // TODO: implement registerCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateCategory(CategoryModel category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}

void main() {
  late final IProductRepository productRepository;
  late final IProductsService productsService;

  setUpAll(() {
    productsService = ProductServiceMock();
    productRepository = ProductRepository(productsService: productsService);
  });

  group('Get products', () {
    test('should get with success', () async {
      when(
        () => productsService.getProducts(),
      ).thenAnswer((_) async => listProductsData);

      final response = await productRepository.getProducts();

      expect(response, listProductsModel);
    });

    test('should call service with correct filter param', () async {
      const filter = 'filtering';

      when(
        () => productsService.getProducts(filter: filter),
      ).thenAnswer((_) async => listProductsData);

      final response = await productRepository.getProducts(filter: filter);

      expect(response, listProductsModel);
    });

    test('should call service with correct categories param', () async {
      when(
        () => productsService.getProducts(categories: listCategoriesData),
      ).thenAnswer((_) async => listProductsData);

      final response = await productRepository.getProducts(
        categories: listCategoriesModel,
      );

      expect(response, listProductsModel);
    });
  });

  test(
      'Register product should call create product on service with correct param',
      () async {
    when(() => productsService.createProduct(productData1))
        .thenAnswer((_) async {});

    await productRepository.registerProduct(productModel1);

    verify(() => productsService.createProduct(productData1));
  });

  test(
      'Update product should call update product on service with correct param',
      () async {
    when(() => productsService.updateProduct(productData1))
        .thenAnswer((_) async {});

    await productRepository.updateProduct(productModel1);

    verify(() => productsService.updateProduct(productData1));
  });

  test(
      'Delete product should call delete product on service with correct param',
      () async {
    when(() => productsService.deleteProduct(productData1))
        .thenAnswer((_) async {});

    await productRepository.deleteProduct(productModel1);

    verify(() => productsService.deleteProduct(productData1));
  });

  test('Get product by id should call service with correct params', () async {
    const id = 1;

    when(() => productsService.getProductById(id))
        .thenAnswer((_) async => productData1);

    final response = await productRepository.getProductById(id);

    expect(response, productModel1);
  });
}
