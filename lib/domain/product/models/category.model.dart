import 'package:ekko/infrastructure/dal/services/data/category.data.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromData(CategoryData data) {
    return CategoryModel(id: data.id, name: data.name);
  }

  @override
  List<Object?> get props => [id, name];
}
