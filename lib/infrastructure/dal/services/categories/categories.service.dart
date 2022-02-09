import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/categories_service.interface.dart';

import '../../../../domain/core/constants/errors.constants.dart';
import '../../../../domain/core/exceptions/default.exception.dart';
import '../../../../domain/core/exceptions/nonexistent.exception.dart';
import '../data/category.data.dart';
import '../data/error.response.dart';
import 'dto/category.response.dart';
import 'dto/get_categories.response.dart';

class CategoriesService implements ICategoriesService {
  final IHttpConnect _connect;
  const CategoriesService(IHttpConnect connect) : _connect = connect;

  final _prefix = 'categories';

  @override
  Future<List<CategoryData>> getCategories({String? filter}) async {
    var url = filter != null ? '$_prefix?filter=$filter' : 'categories';

    final response = await _connect.get(
      url,
      decoder: GetCategoriesResponse.fromJson,
    );

    if (response.success) {
      return response.payload!.data!;
    } else {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> createCategory(CategoryData body) async {
    final response = await _connect.post(
      _prefix,
      body.toJson(),
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> updateCategory(CategoryData body) async {
    final response = await _connect.put(
      '$_prefix/${body.id}',
      body.toJson(),
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<void> deleteCategory(CategoryData body) async {
    final response = await _connect.delete(
      '$_prefix/${body.id}',
      decoder: ErrorResponse.fromJson,
    );

    if (!response.success) {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }

  @override
  Future<CategoryData> getCategoryById(int id) async {
    final response = await _connect.get(
      '$_prefix/$id',
      decoder: CategoryResponse.fromJson,
    );

    if (response.success) {
      return response.payload!.data!;
    } else {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        case ErrosConstants.nonexistent:
          throw NonexistentException(message: error.desc);
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }
}
